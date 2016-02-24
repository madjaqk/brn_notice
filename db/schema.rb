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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160224192734) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text     "comment"
    t.integer  "commenter_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "comments", ["commenter_id"], name: "index_comments_on_commenter_id", using: :btree
  add_index "comments", ["recipient_id"], name: "index_comments_on_recipient_id", using: :btree

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "memberships", ["team_id"], name: "index_memberships_on_team_id", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "pictures", force: :cascade do |t|
    t.string   "picture"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pictures", ["user_id"], name: "index_pictures_on_user_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "updates", force: :cascade do |t|
    t.integer  "current_weight"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "updates", ["user_id"], name: "index_updates_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.text     "about"
    t.integer  "start_weight"
    t.integer  "goal_weight"
    t.string   "profile_picture"
    t.string   "provider"
    t.string   "uid"
    t.decimal  "zip_code",        precision: 5
    t.datetime "end_date"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "watchings", force: :cascade do |t|
    t.integer  "watcher_id"
    t.integer  "watched_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "watchings", ["watched_id"], name: "index_watchings_on_watched_id", using: :btree
  add_index "watchings", ["watcher_id", "watched_id"], name: "index_watchings_on_watcher_id_and_watched_id", unique: true, using: :btree
  add_index "watchings", ["watcher_id"], name: "index_watchings_on_watcher_id", using: :btree

  add_foreign_key "comments", "users", column: "commenter_id"
  add_foreign_key "comments", "users", column: "recipient_id"
  add_foreign_key "memberships", "teams"
  add_foreign_key "memberships", "users"
  add_foreign_key "pictures", "users"
  add_foreign_key "updates", "users"
  add_foreign_key "watchings", "users", column: "watched_id"
  add_foreign_key "watchings", "users", column: "watcher_id"
end
