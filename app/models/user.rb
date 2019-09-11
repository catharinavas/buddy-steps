class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  mount_uploader :photo, PhotoUploader

  has_many :rooms, dependent: :destroy
  has_many :room_messages, dependent: :destroy

  has_many :messages, dependent: :destroy
  has_many :goals, dependent: :destroy

  has_many :comments, dependent: :destroy
  has_many :community_users, dependent: :destroy
  has_many :communities, through: :community_users
  has_many :publications, dependent: :destroy
  has_many :claps, dependent: :destroy
  has_many :user_feelings, dependent: :destroy
  has_many :feelings, through: :user_feelings

  # validates :first_name, presence: true
  # validates :last_name, presence: true

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice("provider", "uid")
    user_params.merge! auth.info.slice("email", "first_name", "last_name")
    user_params[:remote_photo_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end

    return user
  end

end
