class AddReactionsCounterToIdeas < ActiveRecord::Migration
  def up
    add_column :ideas, :reactions_count, :integer, :default => 0

    Idea.reset_column_information
    Idea.all.each do |idea|
      reactions_count = 0
      idea.idea_actions.each do |idea_action|
        idea_action.interactions.each do |interaction|
          reactions_count += 1 if interaction.reaction_text.present?
        end
      end
      Idea.update_counters idea.id, :reactions_count => reactions_count if reactions_count > 0
    end
  end

  def down
    remove_column :ideas, :reactions_count
  end
end
