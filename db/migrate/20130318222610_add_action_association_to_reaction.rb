class AddActionAssociationToReaction < ActiveRecord::Migration
  def change
    add_column :reactions, :idea_action_id, :integer, :default => false
  end
end
