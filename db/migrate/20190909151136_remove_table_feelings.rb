class RemoveTableFeelings < ActiveRecord::Migration[5.2]
  def change
    drop_table :feelings
  end
end
