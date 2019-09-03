class AddPublicationTypeToPublication < ActiveRecord::Migration[5.2]
  def change
    add_reference :publications, :publication_type, foreign_key: true
  end
end
