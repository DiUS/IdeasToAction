class AddFeaturedToEvent < ActiveRecord::Migration
  def change
    add_column :events, :featured, :boolean, :default => false
  end
end
