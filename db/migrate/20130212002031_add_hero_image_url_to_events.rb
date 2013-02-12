class AddHeroImageUrlToEvents < ActiveRecord::Migration
  def change
    add_column :events, :hero_image_url, :text
  end
end
