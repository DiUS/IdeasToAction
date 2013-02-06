class RenameTokenInMember < ActiveRecord::Migration
  def change
    rename_column :members, :token, :persistence_token
  end
end
