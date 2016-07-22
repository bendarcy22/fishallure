class ChangeZipcodeToLatlng < ActiveRecord::Migration
  def up
    remove_column :catches, :zipcode
    add_column :catches, :longitude, :float, null: false
    add_column :catches, :latitude, :float, null: false
  end

  def down
    add_column :catches, :zipcode, :string, null: false
    remove_column :catches, :longitude
    remove_column :catches, :latitude
  end
end
