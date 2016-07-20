class AddLurePhotoToLures < ActiveRecord::Migration
  def change
    add_column :lures, :lure_photo, :string
  end
end
