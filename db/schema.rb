# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_06_09_110208) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "commits", force: :cascade do |t|
    t.text "message"
    t.boolean "published"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "message_date"
    t.string "github_id"
    t.bigint "repository_id"
    t.integer "score", default: 0, null: false
    t.index ["github_id"], name: "index_commits_on_github_id"
    t.index ["repository_id"], name: "index_commits_on_repository_id"
    t.index ["user_id"], name: "index_commits_on_user_id"
  end

  create_table "repositories", force: :cascade do |t|
    t.string "github_username", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "batch"
    t.index ["github_username", "name"], name: "index_repositories_on_github_username_and_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "github_username"
    t.string "batch"
    t.string "photo_url"
    t.string "provider"
    t.string "uid"
    t.integer "kitt_id"
    t.boolean "admin"
    t.index ["batch"], name: "index_users_on_batch"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["github_username"], name: "index_users_on_github_username"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "commit_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "value"
    t.string "session_id"
    t.index ["commit_id"], name: "index_votes_on_commit_id"
  end

  add_foreign_key "commits", "repositories"
  add_foreign_key "commits", "users"
  add_foreign_key "votes", "commits"
end
