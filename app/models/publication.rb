class Publication < ApplicationRecord
  belongs_to :user
  belongs_to :buddy, class_name: "User", foreign_key: "buddy_id"
  belongs_to :community, optional: true


  validates :title, presence: true
  validates :content, presence: true
  validates :publication_type, presence: true

end
