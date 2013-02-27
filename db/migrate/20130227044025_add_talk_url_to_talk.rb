class AddTalkUrlToTalk < ActiveRecord::Migration
  def change
    add_column :talks, :ted_talk_url, :text
  end
end
