class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :token
      t.timestamps
    end
  end
end
