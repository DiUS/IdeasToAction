class AddIdeasCounterToTalks < ActiveRecord::Migration
  def up
    add_column :talks, :ideas_count, :integer, :default => 0
    Talk.all.each do |talk|
      talk.update_attribute :ideas_count, talk.ideas.length
    end
  end

  def down
    remove_column :talks, :ideas_count
  end
end
