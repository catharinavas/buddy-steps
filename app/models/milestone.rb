class Milestone < ApplicationRecord
  belongs_to :goal

  validates :description, presence: true
  validates :deadline, presence: true
end
