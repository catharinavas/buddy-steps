class Feeling < ApplicationRecord
  has_many :user_feelings

  validates :name, presence: true, uniqueness: true
end
