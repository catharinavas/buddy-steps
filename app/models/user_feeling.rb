class UserFeeling < ApplicationRecord
  belongs_to :user
  belongs_to :feeling

  validates :feeling_date, presence: true, uniqueness: true
  validates :intensity, presence: true
end
