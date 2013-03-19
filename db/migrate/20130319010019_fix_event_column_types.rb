class FixEventColumnTypes < ActiveRecord::Migration
  def up
    change_table :events do |t|
      t.change :name, :string
      t.change :logo_image_url, :string
      t.change :hero_image_url, :string
    end
  end

  def down
    change_table :events do |t|
      t.change :name, :text
      t.change :logo_image_url, :text
      t.change :hero_image_url, :text
    end
  end
end
