class RemoveIdeaIdFromReaction < ActiveRecord::Migration
  def up
    remove_column :reactions, :idea_id
  end

  def down
    add_column :reactions, :idea_id, :integer
  end
end
