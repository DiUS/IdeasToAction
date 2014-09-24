class AddViewableToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :viewable, :boolean, default: false
  end
end
