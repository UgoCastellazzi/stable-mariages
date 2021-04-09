class Receiver < ApplicationRecord
  belongs_to :poll
  has_many :matches, dependent: :destroy
  has_one :user, through: :polls

  def still_has_capacity?
    self.matches.length < self.capacity ? true : false
  end
end
