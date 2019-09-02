class Publication < ApplicationRecord
  belongs_to :user
  belongs_to :community, optional: true


  validates :title, presence: true
  validates :content, presence: true
  validates :publication_type, presence: true

end
