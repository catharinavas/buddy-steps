class ChangeContentToTextInPublications < ActiveRecord::Migration[5.2]
  def change
    change_column :publications, :content, :text
  end
end
