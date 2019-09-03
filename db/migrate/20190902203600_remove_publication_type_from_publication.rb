class RemovePublicationTypeFromPublication < ActiveRecord::Migration[5.2]
  def change
    remove_column :publications, :publication_type, :string
  end
end
