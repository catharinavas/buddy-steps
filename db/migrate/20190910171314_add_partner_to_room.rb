class AddPartnerToRoom < ActiveRecord::Migration[5.2]
  def change
    add_reference :rooms, :user, foreign_key: true

    add_column :rooms, :partner_id, :integer
    add_index :rooms, :partner_id
  end
end
