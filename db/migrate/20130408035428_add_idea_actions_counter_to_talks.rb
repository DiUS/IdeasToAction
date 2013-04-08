class AddIdeaActionsCounterToTalks < ActiveRecord::Migration
  def up
    add_column :talks, :idea_actions_count, :integer, :default => 0

    Talk.all.each do |talk|
      talk.update_attribute :idea_actions_count, talk.idea_actions.length
    end
  end

  def down
    remove_column :talks, :idea_actions_count
  end
end
