class CreateFish < ActiveRecord::Migration
  def change
    create_table :fish_types do |t|
      t.string :name, null: false
      t.string :user_id, null: false
      t.text :description
    end
  end
end
