require 'faker'

User.destroy_all
Poll.destroy_all
Receiver.destroy_all
Match.destroy_all
Respondent.destroy_all
puts "DB cleaned!"

agathe = User.new(
  name: "Agathe",
  email: "agathe@test.com",
  password: "Test1234"
)
agathe.save!

poll = Poll.new(
  name: "Poll 1",
  user: agathe
)
poll.save!

puts "creating receivers"
5.times do 
  receiver = Receiver.new(
    name: Faker::Company.name,
    capacity: rand(1..5),
    poll: poll
  )
  receiver.save!
end
puts "receivers created!"

puts "computing capacity"
capacity = 0
Receiver.all.each do |receiver|
  capacity += receiver.capacity
end

puts "creating #{capacity} respondents"
capacity.times do 
  respondent = Respondent.new(
    name: Faker::Name.name,
    poll: poll
  )
  respondent.save!
end
respondents = Respondent.all
puts "respondents created!"

puts "creating respondent wishes"
respondents.each do |respondent|
  receivers = Receiver.all
  while respondent.wishes.length < Receiver.all.length do
    current_wish = receivers.sample
    respondent.wishes << current_wish.id
    receivers = receivers.reject{ |k| k==current_wish}
  end
  respondent.save!
end
puts "respondent wishes created"
