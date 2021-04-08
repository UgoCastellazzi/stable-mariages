class Poll < ApplicationRecord
  belongs_to :user
  has_many :receivers, dependent: :destroy
  has_many :matches, dependent: :destroy
  has_many :respondents, dependent: :destroy
end
