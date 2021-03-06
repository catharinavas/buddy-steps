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

ActiveRecord::Schema.define(version: 2019_09_11_110937) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "claps", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "publication_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publication_id"], name: "index_claps_on_publication_id"
    t.index ["user_id"], name: "index_claps_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "publication_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publication_id"], name: "index_comments_on_publication_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "communities", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "community_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "community_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_community_users_on_community_id"
    t.index ["user_id"], name: "index_community_users_on_user_id"
  end

  create_table "goals", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.date "start_date"
    t.date "deadline"
    t.bigint "user_id"
    t.bigint "category_id"
    t.boolean "complete", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "buddy_id"
    t.boolean "confirmed_buddy", default: false
    t.index ["buddy_id"], name: "index_goals_on_buddy_id"
    t.index ["category_id"], name: "index_goals_on_category_id"
    t.index ["user_id"], name: "index_goals_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.bigint "user_id"
    t.bigint "goal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["goal_id"], name: "index_messages_on_goal_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "milestones", force: :cascade do |t|
    t.string "description"
    t.date "deadline"
    t.bigint "goal_id"
    t.boolean "complete", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["goal_id"], name: "index_milestones_on_goal_id"
  end

  create_table "publication_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "publications", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.bigint "user_id"
    t.bigint "community_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_private", default: false
    t.bigint "publication_type_id"
    t.string "photo", default: ""
    t.index ["community_id"], name: "index_publications_on_community_id"
    t.index ["publication_type_id"], name: "index_publications_on_publication_type_id"
    t.index ["user_id"], name: "index_publications_on_user_id"
  end

  create_table "room_messages", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "room_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_room_messages_on_room_id"
    t.index ["user_id"], name: "index_room_messages_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "partner_id"
    t.index ["partner_id"], name: "index_rooms_on_partner_id"
    t.index ["user_id"], name: "index_rooms_on_user_id"
  end

  create_table "user_feelings", force: :cascade do |t|
    t.bigint "user_id"
    t.date "feeling_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "carefreeness", default: 3
    t.integer "patience", default: 3
    t.integer "sleep_quality", default: 3
    t.integer "happiness", default: 3
    t.index ["user_id"], name: "index_user_feelings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "photo"
    t.string "city"
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.datetime "token_expiry"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "claps", "publications"
  add_foreign_key "claps", "users"
  add_foreign_key "comments", "publications"
  add_foreign_key "comments", "users"
  add_foreign_key "community_users", "communities"
  add_foreign_key "community_users", "users"
  add_foreign_key "goals", "categories"
  add_foreign_key "goals", "users"
  add_foreign_key "messages", "goals"
  add_foreign_key "messages", "users"
  add_foreign_key "milestones", "goals"
  add_foreign_key "publications", "communities"
  add_foreign_key "publications", "publication_types"
  add_foreign_key "publications", "users"
  add_foreign_key "room_messages", "rooms"
  add_foreign_key "room_messages", "users"
  add_foreign_key "rooms", "users"
  add_foreign_key "user_feelings", "users"
end
