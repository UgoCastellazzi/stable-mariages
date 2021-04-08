class Match < ApplicationRecord
  belongs_to :receiver
  belongs_to :respondent
  belongs_to :poll
end
