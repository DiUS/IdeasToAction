class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :body

      t.timestamps
    end
  end
end
