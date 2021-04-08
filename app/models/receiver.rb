class Receiver < ApplicationRecord
  belongs_to :poll
  has_many :matches, dependent: :destroy

  def still_has_capacity?
    self.matches.length < self.capacity ? true : false
  end
end
