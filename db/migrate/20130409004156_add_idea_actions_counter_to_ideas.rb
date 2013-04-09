class AddIdeaActionsCounterToIdeas < ActiveRecord::Migration
  def up
    add_column :ideas, :idea_actions_count, :integer, :default => 0

    Idea.reset_column_information
    Idea.all.each do |idea|
      Idea.update_counters idea.id, :idea_actions_count => idea.idea_actions.length
    end
  end

  def down
    remove_column :ideas, :idea_actions_count
  end
end
