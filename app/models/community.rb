class Community < ApplicationRecord

  has_many :publications, dependent: :destroy
  has_many :users, through: :community_users

  validates :name, presence: true, uniqueness: true
end
