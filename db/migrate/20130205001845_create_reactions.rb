class CreateReactions < ActiveRecord::Migration
  def change
    create_table :reactions do |t|
      t.integer :member_id
      t.integer :idea_id
      t.string  :text
      t.timestamps
    end
  end
end
