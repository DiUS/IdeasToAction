class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :name
      t.timestamps
    end
  end
end
