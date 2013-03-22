class AddReactionTextToInteractions < ActiveRecord::Migration
  def change
    add_column :interactions, :reaction_text, :text
  end
end
