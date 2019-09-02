class IntensityToUserFeelings < ActiveRecord::Migration[5.2]
  def change
    add_column :user_feelings, :intensity, :integer, default: 3
  end
end
