class RemoveDescriptionFromCategory < ActiveRecord::Migration[5.2]
  def change
    remove_column :categories, :description, :string
  end
end
