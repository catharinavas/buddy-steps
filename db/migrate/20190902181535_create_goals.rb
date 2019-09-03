class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.string :title
      t.string :description
      t.date :start_date
      t.date :deadline
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
      t.boolean :complete, default: false

      t.timestamps
    end
  end
end
