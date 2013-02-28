class ChangeEventNameToString < ActiveRecord::Migration
  def up
    remove_column :events, :name
    add_column :events, :name, :text
  end

  def down
    remove_column :events, :name
    add_column :events, :name, :integer
  end
end
