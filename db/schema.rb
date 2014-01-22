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

ActiveRecord::Schema.define(version: 20140122200415) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "commits", force: true do |t|
    t.string   "commit_hash"
    t.text     "message"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "repo_id"
    t.string   "email"
    t.string   "name"
  end

  add_index "commits", ["repo_id"], name: "index_commits_on_repo_id", using: :btree

  create_table "project_repos", force: true do |t|
    t.integer  "project_id"
    t.integer  "repo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_repos", ["project_id"], name: "index_project_repos_on_project_id", using: :btree
  add_index "project_repos", ["repo_id"], name: "index_project_repos_on_repo_id", using: :btree

  create_table "projects", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "repos", force: true do |t|
    t.string   "github_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "gh_repo_id"
  end

  add_index "repos", ["gh_repo_id"], name: "index_repos_on_gh_repo_id", unique: true, using: :btree

  create_table "tracker_events", force: true do |t|
    t.string   "story_url"
    t.string   "message"
    t.string   "kind"
    t.string   "user_name"
    t.integer  "story_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tracker_project_id"
  end

  add_index "tracker_events", ["tracker_project_id"], name: "index_tracker_events_on_tracker_project_id", using: :btree

  create_table "tracker_projects", force: true do |t|
    t.integer  "project_id"
    t.integer  "pt_project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "uid"
    t.string   "nickname"
    t.string   "name"
    t.string   "image_url"
    t.string   "github_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
