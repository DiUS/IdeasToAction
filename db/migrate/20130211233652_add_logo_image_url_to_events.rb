class AddLogoImageUrlToEvents < ActiveRecord::Migration
  def change
    add_column :events, :logo_image_url, :text
  end
end
