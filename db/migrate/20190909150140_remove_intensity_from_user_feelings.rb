class RemoveIntensityFromUserFeelings < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_feelings, :intensity, :integer
  end
end
