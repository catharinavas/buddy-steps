class AddConfirmedBuddyToGoal < ActiveRecord::Migration[5.2]
  def change
    add_column :goals, :confirmed_buddy, :boolean, default: false
  end
end
