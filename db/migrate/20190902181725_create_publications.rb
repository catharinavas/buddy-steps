class CreatePublications < ActiveRecord::Migration[5.2]
  def change
    create_table :publications do |t|
      t.string :title
      t.string :content
      t.string :publication_type
      t.references :user, foreign_key: true
      t.references :community, foreign_key: true

      t.timestamps
    end
  end
end
