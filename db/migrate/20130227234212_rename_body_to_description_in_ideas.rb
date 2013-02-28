class RenameBodyToDescriptionInIdeas < ActiveRecord::Migration
  def change
    rename_column :ideas, :body, :description
  end

end
