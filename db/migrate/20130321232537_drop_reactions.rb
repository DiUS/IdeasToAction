class DropReactions < ActiveRecord::Migration
  def up
    drop_table :reactions
  end

  def down
    create_table "reactions", :force => true do |t|
      t.integer  "member_id"
      t.text     "text"
      t.datetime "created_at",                    :null => false
      t.datetime "updated_at",                    :null => false
      t.integer  "idea_action_id", :default => 0
    end
  end
end
