class AddReactionsCounterToTalks < ActiveRecord::Migration
  def up
    add_column :talks, :reactions_count, :integer, :default => 0

    Talk.all.each do |talk|
      talk.idea_actions.each do |idea_action|
        idea_action.interactions.each do |interaction|
          Talk.increment_counter(:reactions_count, talk.id) if interaction.reaction_text.present?
        end
      end
    end
  end

  def down
    remove_column :talks, :reactions_count
  end
end
