class AddIdeasCounterToEvents < ActiveRecord::Migration
  def up
    add_column :events, :ideas_count, :integer, :default => 0
    Event.all.each do |event|
      event.update_attribute :ideas_count, event.ideas.length
    end
  end

  def down
    remove_column :events, :ideas_count
  end
end
