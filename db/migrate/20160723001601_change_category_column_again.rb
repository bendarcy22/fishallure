class ChangeCategoryColumnAgain < ActiveRecord::Migration
  def change
    change_column :lures, :category, :string, null: false
  end
end
