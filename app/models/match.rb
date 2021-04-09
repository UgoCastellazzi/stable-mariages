class Match < ApplicationRecord
  belongs_to :receiver
  belongs_to :respondent
  belongs_to :poll

  def get_match_rank(respondent)
    respondent.wishes.find_index(self.receiver_id.to_s)
  end
end
