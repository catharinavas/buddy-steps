class AddCollumnToGoal < ActiveRecord::Migration[5.2]
  def change
    add_column :goals, :buddy_id, :integer
    add_index :goals, :buddy_id
  end
end
