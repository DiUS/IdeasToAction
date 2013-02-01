class CreateTalkToIdeaAssociations < ActiveRecord::Migration
  def change
    create_table :talk_to_idea_associations do |t|
      t.integer :talk_id
      t.integer :idea_id

      t.timestamps
    end
  end
end
