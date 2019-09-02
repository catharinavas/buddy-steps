class AddPrivateToPublications < ActiveRecord::Migration[5.2]
  def change
    add_column :publications, :is_private, :boolean, default: false
  end
end
