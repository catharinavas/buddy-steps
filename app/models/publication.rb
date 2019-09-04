class Publication < ApplicationRecord
  belongs_to :user
  belongs_to :community, optional: true
  belongs_to :publication_type
  has_many :claps

  validates :title, presence: true
  validates :content, presence: true
  validates :publication_type_id, presence: true
end
