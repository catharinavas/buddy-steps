class Publication < ApplicationRecord
  # searchkick
  mount_uploader :photo, PhotoUploader

  belongs_to :user
  belongs_to :community, optional: true
  belongs_to :publication_type
  has_many :claps, dependent: :destroy
  has_many :comments, dependent: :destroy

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :title, :content ],
    associated_against: {
      user: [ :first_name, :last_name ]
    },
    using: {
      tsearch: { prefix: true }
    }

  validates :title, presence: true
  validates :content, presence: true
  validates :publication_type_id, presence: true
end
