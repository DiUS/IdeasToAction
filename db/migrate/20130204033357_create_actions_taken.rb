class CreateActionsTaken < ActiveRecord::Migration
  def change
    create_table :actions_taken do |t|
      t.integer :action_id
      t.integer :member_id
      t.timestamps
    end
  end
end
