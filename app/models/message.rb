class Message < ApplicationRecord
  belongs_to :goal
  belongs_to :user

  validates :content, presence: true
end
