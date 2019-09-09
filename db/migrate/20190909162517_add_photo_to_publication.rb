class AddPhotoToPublication < ActiveRecord::Migration[5.2]
  def change
    add_column :publications, :photo, :string, default: ""
  end
end
