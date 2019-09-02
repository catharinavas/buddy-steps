class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :content
      t.date :user
      t.references :goal, foreign_key: true

      t.timestamps
    end
  end
end
