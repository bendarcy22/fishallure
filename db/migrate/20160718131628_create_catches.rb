class CreateCatches < ActiveRecord::Migration
  def change
    create_table :catches do |t|
      t.integer :user_id, null: false
      t.integer :lure_id, null: false
      t.integer :fish_type_id, null: false
      t.string :zipcode, null: false
      t.datetime :caught_at, null: false
    end
  end
end
