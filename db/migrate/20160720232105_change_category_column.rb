class ChangeCategoryColumn < ActiveRecord::Migration
  def change
    rename_column :lures, :category_id, :category
  end
end
