class AddHeroImageUrlToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :hero_image_url, :text
  end
end
