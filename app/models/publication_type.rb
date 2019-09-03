class PublicationType < ApplicationRecord
  has_many :publications

  validates :name, presence: true
end
