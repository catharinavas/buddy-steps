class Room < ApplicationRecord
  belongs_to :user
  belongs_to :partner, class_name: "User", foreign_key: "partner_id"
  has_many :room_messages, dependent: :destroy

end
