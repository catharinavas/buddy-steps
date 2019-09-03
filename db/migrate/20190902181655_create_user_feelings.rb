class CreateUserFeelings < ActiveRecord::Migration[5.2]
  def change
    create_table :user_feelings do |t|
      t.references :user, foreign_key: true
      t.references :feeling, foreign_key: true
      t.date :feeling_date

      t.timestamps
    end
  end
end
