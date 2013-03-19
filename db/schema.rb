# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130318223954) do

  create_table "actions_taken", :force => true do |t|
    t.integer  "idea_action_id"
    t.integer  "member_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "events", :force => true do |t|
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.text     "name"
    t.text     "logo_image_url"
    t.text     "description"
    t.text     "hero_image_url"
    t.boolean  "featured",       :default => false
  end

  create_table "idea_actions", :force => true do |t|
    t.text     "description"
    t.integer  "idea_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "featured",    :default => false
  end

  create_table "ideas", :force => true do |t|
    t.text     "description"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "member_id"
    t.boolean  "featured",    :default => false
  end

  create_table "ideas_tags", :force => true do |t|
    t.integer  "idea_id"
    t.integer  "tag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "members", :force => true do |t|
    t.string   "persistence_token"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "username"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "role",              :default => "REGULAR"
  end

  create_table "reactions", :force => true do |t|
    t.integer  "member_id"
    t.text     "text"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "idea_action_id", :default => 0
  end

  create_table "tags", :force => true do |t|
    t.text     "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "talk_to_idea_associations", :force => true do |t|
    t.integer  "talk_id"
    t.integer  "idea_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "talks", :force => true do |t|
    t.text     "title"
    t.text     "description"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "event_id"
    t.text     "hero_image_url"
    t.text     "ted_talk_url"
    t.boolean  "featured",       :default => false
  end

end
