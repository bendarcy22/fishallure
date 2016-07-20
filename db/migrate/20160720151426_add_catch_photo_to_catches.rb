class AddCatchPhotoToCatches < ActiveRecord::Migration
  def change
    add_column :catches, :catch_photo, :string
  end
end
