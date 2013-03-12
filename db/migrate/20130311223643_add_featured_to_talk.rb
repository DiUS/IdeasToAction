class AddFeaturedToTalk < ActiveRecord::Migration
  def change
    add_column :talks, :featured, :boolean, :default => false
  end
end
