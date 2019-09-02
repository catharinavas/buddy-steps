class Category < ApplicationRecord
  has_many :goals

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
