class Respondent < ApplicationRecord
  belongs_to :poll
  has_one :match, dependent: :destroy

  def get_personal_match_rank
    self.wishes.find_index(self.match.receiver_id.to_s)
  end
end
