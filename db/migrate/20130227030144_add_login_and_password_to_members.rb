class AddLoginAndPasswordToMembers < ActiveRecord::Migration
  def change
    add_column :members, :username, :string
    add_column :members, :crypted_password, :string
    add_column :members, :password_salt, :string
  end
end
