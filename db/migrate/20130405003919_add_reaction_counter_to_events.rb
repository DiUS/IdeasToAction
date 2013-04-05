class AddReactionCounterToEvents < ActiveRecord::Migration
  def up
    add_column :events, :reactions_count, :integer, :default => 0

    Event.all.each do |event|
      event.idea_actions.each do |idea_action|
        idea_action.interactions.each do |interaction|
          Event.increment_counter(:reactions_count, event.id) if interaction.reaction_text.present?
        end
      end
    end
  end

  def down
    remove_column :events, :reactions_count
  end
end
