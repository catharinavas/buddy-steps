class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :photo, PhotoUploader

  has_many :goals, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :community_users
  has_many :communities, through: :community_users
  has_many :publications, dependent: :destroy
  has_many :claps, dependent: :destroy
  has_many :user_feelings, dependent: :destroy

  # validates :first_name, presence: true
  # validates :last_name, presence: true
end
