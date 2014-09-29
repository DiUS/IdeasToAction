class AddTargetDateToIdeaActions < ActiveRecord::Migration
  def change
		add_column :idea_actions, :target_date, :datetime
  end
end
