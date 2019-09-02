class CreateMilestones < ActiveRecord::Migration[5.2]
  def change
    create_table :milestones do |t|
      t.string :description
      t.date :deadline
      t.references :goal, foreign_key: true
      t.boolean :complete, default: false

      t.timestamps
    end
  end
end
