class RemoveInteractions < ActiveRecord::Migration
  def up
		remove_column :talks, :reactions_count
		remove_column :ideas, :reactions_count
		remove_column :idea_actions, :reactions_count

		drop_table :interactions
	end

  def down
		add_column :talks, :reactions_count, :integer, :default => 0
		add_column :ideas, :reactions_count, :integer, :default => 0
		add_column :idea_actions, :reactions_count, :integer, :default => 0

		create_table 'interactions' do |t|
			t.integer  'idea_action_id'
			t.integer  'member_id'
			t.datetime 'created_at',     :null => false
			t.datetime 'updated_at',     :null => false
			t.text     'reaction_text'
		end
  end
end
