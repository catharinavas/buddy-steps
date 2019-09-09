class AddColumnToUserFeelings < ActiveRecord::Migration[5.2]
  def change
    add_column :user_feelings, :carefreeness, :integer, default: 3
    add_column :user_feelings, :patience, :integer, default: 3
    add_column :user_feelings, :sleep_quality, :integer, default: 3
    add_column :user_feelings, :happiness, :integer, default: 3
  end
end
