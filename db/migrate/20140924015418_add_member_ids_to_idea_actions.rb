class AddMemberIdsToIdeaActions < ActiveRecord::Migration
  def change
		add_column :idea_actions, :member_id, :integer, :null => false
		add_index :idea_actions, :member_id
  end
end
