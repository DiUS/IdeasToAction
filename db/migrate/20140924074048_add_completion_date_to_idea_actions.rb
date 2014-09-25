class AddCompletionDateToIdeaActions < ActiveRecord::Migration
  def change
		add_column :idea_actions, :completion_date, :datetime
  end
end
