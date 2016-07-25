class ChangeCaughtAtToDate < ActiveRecord::Migration
  def up
    change_column :catches, :caught_at, :date
  end
  def down
    change_column :catches, :caught_at, :datetime
  end
end
