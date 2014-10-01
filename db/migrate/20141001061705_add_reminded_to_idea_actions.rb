class AddRemindedToIdeaActions < ActiveRecord::Migration
  def change
    add_column :idea_actions, :reminded, :boolean, default: false
  end
end
