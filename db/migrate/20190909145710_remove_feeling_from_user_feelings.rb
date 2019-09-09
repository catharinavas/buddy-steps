class RemoveFeelingFromUserFeelings < ActiveRecord::Migration[5.2]
  def change
    remove_reference :user_feelings, :feeling, foreign_key: true
  end
end
