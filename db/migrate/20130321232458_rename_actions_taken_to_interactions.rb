class RenameActionsTakenToInteractions < ActiveRecord::Migration
  def change
    rename_table :actions_taken, :interactions
  end
end
