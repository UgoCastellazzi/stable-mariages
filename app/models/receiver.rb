class Receiver < ApplicationRecord
  belongs_to :poll
  has_one :match, dependent: :destroy
end
