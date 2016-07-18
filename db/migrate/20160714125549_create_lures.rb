class CreateLures < ActiveRecord::Migration
  def change
    create_table :lures do |t|
      t.string :name, null: false
      t.string :manufacturer, null: false
      t.integer :category_id, null: false
      t.integer :user_id, null: false
      t.text :description
    end
  end
end
