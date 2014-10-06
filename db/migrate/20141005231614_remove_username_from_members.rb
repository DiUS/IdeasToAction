class RemoveUsernameFromMembers < ActiveRecord::Migration
  def up
		remove_column :members, :username
  end

  def down
		add_column :members, :username, :string
  end
end
