class AddMemberIdToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :member_id, :integer
  end
end
