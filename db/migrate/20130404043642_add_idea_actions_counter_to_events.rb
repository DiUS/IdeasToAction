class AddIdeaActionsCounterToEvents < ActiveRecord::Migration
  def up
    add_column :events, :idea_actions_count, :integer, :default => 0
    Event.all.each do |event|
      event.update_attribute :idea_actions_count, event.idea_actions.length
    end
  end

  def down
    remove_column :events, :idea_actions_count
  end
end
