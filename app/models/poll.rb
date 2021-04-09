class Poll < ApplicationRecord
  belongs_to :user
  has_many :receivers, dependent: :destroy
  has_many :matches, dependent: :destroy
  has_many :respondents, dependent: :destroy

  def generate_matches
    respondents = self.respondents.shuffle.to_a
    respondents.each do |respondent|
      respondent.wishes.each do |wish|
        receiver_chosen = Receiver.find(wish)
        if receiver_chosen.still_has_capacity?
          match = Match.new(
            receiver: receiver_chosen,
            respondent: respondent,
            poll: self
          )
          match.save!
          break
        else
        end
      end
    end
  end

  def stabilize_matches
    respondents = self.respondents
    respondents.each do |respondent1|
      respondent1_personnal_match_rank = respondent1.get_personal_match_rank
      if respondent1_personnal_match_rank == 0
        next
      else
        other_respondents = respondents.reject{ |k| k==respondent1}
        other_respondents.each do |respondent2|
          respondent1_match_rank_for_respondent2 = respondent1.match.get_match_rank(respondent2)
          respondent2_personnal_match_rank = respondent2.get_personal_match_rank
          respondent2_match_rank_for_respondent1 = respondent2.match.get_match_rank(respondent1)
          if respondent1_match_rank_for_respondent2 < respondent2_personnal_match_rank && respondent2_match_rank_for_respondent1 < respondent1_personnal_match_rank
            receiver1 = respondent1.match.receiver
            match1 = respondent1.match
            match1.delete
            receiver2 = respondent2.match.receiver
            match2 = respondent2.match
            match2.delete
            Match.create!(
              receiver: receiver1,
              respondent: respondent2,
              poll: self
            )
            Match.create!(
              receiver: receiver2,
              respondent: respondent1,
              poll: self
            )
            puts "#{respondent1.name} and #{respondent2.name} have switched"
            break
          else
            puts "this is optimal"
          end
        end
      end
    end
  end

end
