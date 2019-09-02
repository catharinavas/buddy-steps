class Goal < ApplicationRecord
  belongs_to :user
  belongs_to :buddy, class_name: "User", foreign_key: "buddy_id"
  belongs_to :category


  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :deadline, presence: true
  validates :buddy, presence: true

end
