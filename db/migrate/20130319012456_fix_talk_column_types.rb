class FixTalkColumnTypes < ActiveRecord::Migration
  def up
    change_table :talks do |t|
      t.change :title, :string
      t.change :hero_image_url, :string
      t.change :ted_talk_url, :string
    end
  end

  def down
    change_table :talks do |t|
      t.change :title, :text
      t.change :hero_image_url, :text
      t.change :ted_talk_url, :text
    end
  end
end
