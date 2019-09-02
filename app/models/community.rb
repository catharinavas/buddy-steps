class Community < ApplicationRecord

  has_many :publications, dependent: :destroy
  has_many :users, through: :community_users
  has_many :community_users, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
