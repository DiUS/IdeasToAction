class RenameActionsToIdeaActions < ActiveRecord::Migration
  def change
    rename_table :actions, :idea_actions
    rename_column :actions_taken, :action_id, :idea_action_id
  end
end
