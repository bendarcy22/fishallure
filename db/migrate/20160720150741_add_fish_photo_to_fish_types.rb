class AddFishPhotoToFishTypes < ActiveRecord::Migration
  def change
    add_column :fish_types, :fish_photo, :string
  end
end
