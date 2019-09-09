class UserFeeling < ApplicationRecord
  belongs_to :user

  validates :feeling_date, presence: true
end
