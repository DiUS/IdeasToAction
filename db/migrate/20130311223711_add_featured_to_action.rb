class AddFeaturedToAction < ActiveRecord::Migration
  def change
    add_column :actions, :featured, :boolean, :default => false
  end
end
