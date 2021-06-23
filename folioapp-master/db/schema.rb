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

ActiveRecord::Schema.define(version: 20140729122008) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collections", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "work_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "collections", ["user_id"], name: "index_collections_on_user_id", using: :btree
  add_index "collections", ["work_id"], name: "index_collections_on_work_id", using: :btree

  create_table "follows", force: true do |t|
    t.integer  "followable_id",                   null: false
    t.string   "followable_type",                 null: false
    t.integer  "follower_id",                     null: false
    t.string   "follower_type",                   null: false
    t.boolean  "blocked",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables", using: :btree
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows", using: :btree

  create_table "genres", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres_works", id: false, force: true do |t|
    t.integer "work_id",  null: false
    t.integer "genre_id", null: false
  end

  create_table "media", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "media_works", id: false, force: true do |t|
    t.integer "work_id",   null: false
    t.integer "medium_id", null: false
  end

  create_table "memberships", force: true do |t|
    t.integer  "user_id"
    t.integer  "organisation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
  end

  add_index "memberships", ["organisation_id"], name: "index_memberships_on_organisation_id", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "opportunities", force: true do |t|
    t.integer  "organisation_id"
    t.string   "title"
    t.text     "description"
    t.text     "requirements"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "opportunities", ["organisation_id"], name: "index_opportunities_on_organisation_id", using: :btree

  create_table "organisations", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "network"
    t.string   "organisation_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "organisations_users", id: false, force: true do |t|
    t.integer "user_id",         null: false
    t.integer "organisation_id", null: false
  end

  create_table "submissions", force: true do |t|
    t.integer  "opportunity_id"
    t.integer  "organisation_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "message"
    t.string   "status"
  end

  add_index "submissions", ["opportunity_id"], name: "index_submissions_on_opportunity_id", using: :btree
  add_index "submissions", ["organisation_id"], name: "index_submissions_on_organisation_id", using: :btree
  add_index "submissions", ["user_id"], name: "index_submissions_on_user_id", using: :btree

  create_table "submissions_works", id: false, force: true do |t|
    t.integer "work_id",       null: false
    t.integer "submission_id", null: false
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "profession"
    t.string   "network"
    t.text     "short_bio"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "provider"
    t.string   "uid"
    t.integer  "work_selection_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["work_selection_id"], name: "index_users_on_work_selection_id", using: :btree

  create_table "users_work_selections", id: false, force: true do |t|
    t.integer "user_id",           null: false
    t.integer "work_selection_id", null: false
  end

  create_table "work_selections", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "work_selections", ["user_id"], name: "index_work_selections_on_user_id", using: :btree

  create_table "works", force: true do |t|
    t.integer  "user_id"
    t.text     "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "caption"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "collection_id"
    t.string   "format"
    t.text     "text"
    t.integer  "submission_id"
    t.integer  "work_selection_id"
  end

  add_index "works", ["collection_id"], name: "index_works_on_collection_id", using: :btree
  add_index "works", ["submission_id"], name: "index_works_on_submission_id", using: :btree
  add_index "works", ["user_id"], name: "index_works_on_user_id", using: :btree
  add_index "works", ["work_selection_id"], name: "index_works_on_work_selection_id", using: :btree

  create_table "workselections", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "work_id"
  end

  add_index "workselections", ["user_id"], name: "index_workselections_on_user_id", using: :btree
  add_index "workselections", ["work_id"], name: "index_workselections_on_work_id", using: :btree

end
