class AddRolesToMembers < ActiveRecord::Migration
  def change
    add_column :members, :role, :string, :default => Member::ROLE_REGULAR
  end
end
