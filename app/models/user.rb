class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :goals, dependent: :destroy
  has_many :communities, through: :community_users
  has_many :publications
  has_many :user_feelings, dependent: :destroy

  # validates :first_name, presence: true
  # validates :last_name, presence: true
end
