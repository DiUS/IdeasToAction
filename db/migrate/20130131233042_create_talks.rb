class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.text :title
      t.text :description

      t.timestamps
    end
  end
end
