class AddReactionsCounterToIdeaActions < ActiveRecord::Migration
  def up
    add_column :idea_actions, :reactions_count, :integer, :default => 0

    IdeaAction.reset_column_information
    IdeaAction.all.each do |idea_action|
      reactions_count = 0
      idea_action.interactions.each do |interaction|
        reactions_count += 1 if interaction.reaction_text.present?
      end
      IdeaAction.update_counters idea_action.id, :reactions_count => reactions_count if reactions_count > 0
    end
  end

  def down
    remove_column :idea_actions, :reactions_count
  end
end
