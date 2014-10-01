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

ActiveRecord::Schema.define(:version => 20141001061705) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0, :null => false
    t.integer  "attempts",   :default => 0, :null => false
    t.text     "handler",                   :null => false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "events", :force => true do |t|
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "name"
    t.string   "logo_image_url"
    t.text     "description"
    t.string   "hero_image_url"
    t.boolean  "featured",           :default => false
    t.integer  "idea_actions_count", :default => 0
    t.integer  "ideas_count",        :default => 0
    t.integer  "reactions_count",    :default => 0
  end

  create_table "idea_actions", :force => true do |t|
    t.text     "description"
    t.integer  "idea_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.boolean  "featured",        :default => false
    t.integer  "member_id",                          :null => false
    t.datetime "completion_date"
    t.datetime "target_date"
    t.boolean  "reminded",        :default => false
  end

  add_index "idea_actions", ["member_id"], :name => "index_idea_actions_on_member_id"

  create_table "ideas", :force => true do |t|
    t.text     "description"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "member_id"
    t.boolean  "featured",           :default => false
    t.integer  "idea_actions_count", :default => 0
  end

  create_table "ideas_tags", :force => true do |t|
    t.integer "idea_id"
    t.integer "tag_id"
  end

  create_table "members", :force => true do |t|
    t.string   "persistence_token"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "username"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "role",              :default => "REGULAR"
    t.string   "email"
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
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "event_id"
    t.string   "hero_image_url"
    t.string   "ted_talk_url"
    t.boolean  "featured",           :default => false
    t.integer  "ideas_count",        :default => 0
    t.integer  "idea_actions_count", :default => 0
    t.boolean  "viewable",           :default => false
  end

end
