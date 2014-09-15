class IdeasTagsDropTimestamps < ActiveRecord::Migration
  def up
		remove_column :ideas_tags, :created_at
		remove_column :ideas_tags, :updated_at
  end

  def down
		add_column :ideas_tags, :created_at, :datetime
		add_column :ideas_tags, :updated_at, :datetime
  end
end
