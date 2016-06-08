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

ActiveRecord::Schema.define(version: 20160519173646) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "athletes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "athletes_roles", id: false, force: :cascade do |t|
    t.integer "athlete_id"
    t.integer "role_id"
    t.index ["athlete_id", "role_id"], name: "index_athletes_roles_on_athlete_id_and_role_id", using: :btree
  end

  create_table "bodyweights", force: :cascade do |t|
    t.integer  "weight"
    t.integer  "prep_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prep_id"], name: "index_bodyweights_on_prep_id", using: :btree
  end

  create_table "cardios", force: :cascade do |t|
    t.integer  "duration"
    t.string   "activity"
    t.string   "style"
    t.integer  "prep_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prep_id"], name: "index_cardios_on_prep_id", using: :btree
  end

  create_table "certifications", force: :cascade do |t|
    t.string   "name"
    t.datetime "date_granted"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_certifications_on_user_id", using: :btree
  end

  create_table "contests", force: :cascade do |t|
    t.string   "title"
    t.integer  "prep_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "date"
    t.string   "url"
    t.index ["prep_id"], name: "index_contests_on_prep_id", using: :btree
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "invitations", force: :cascade do |t|
    t.integer  "prep_id"
    t.integer  "user_id"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prep_id"], name: "index_invitations_on_prep_id", using: :btree
    t.index ["user_id"], name: "index_invitations_on_user_id", using: :btree
  end

  create_table "macros", force: :cascade do |t|
    t.integer  "protein"
    t.integer  "carbs"
    t.integer  "fat"
    t.integer  "fiber"
    t.integer  "prep_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prep_id"], name: "index_macros_on_prep_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.boolean  "read",            default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "philosophies", force: :cascade do |t|
    t.text     "words"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_philosophies_on_user_id", using: :btree
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "prep_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["prep_id"], name: "index_photos_on_prep_id", using: :btree
  end

  create_table "preps", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "coach_id"
    t.index ["user_id"], name: "index_preps_on_user_id", using: :btree
  end

  create_table "resourceries", force: :cascade do |t|
    t.integer  "prep_id"
    t.integer  "resource_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "read",        default: false
    t.index ["prep_id"], name: "index_resourceries_on_prep_id", using: :btree
    t.index ["resource_id"], name: "index_resourceries_on_resource_id", using: :btree
  end

  create_table "resources", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "body"
    t.string   "title"
    t.string   "url"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
    t.index ["user_id"], name: "index_resources_on_user_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "photo_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["photo_id"], name: "index_taggings_on_photo_id", using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "target_cardios", force: :cascade do |t|
    t.integer  "duration"
    t.string   "activity"
    t.string   "style"
    t.integer  "prep_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prep_id"], name: "index_target_cardios_on_prep_id", using: :btree
  end

  create_table "target_macros", force: :cascade do |t|
    t.integer  "protein"
    t.integer  "carbs"
    t.integer  "fat"
    t.integer  "fiber"
    t.integer  "prep_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prep_id"], name: "index_target_macros_on_prep_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "gender"
    t.integer  "age"
    t.text     "bio"
    t.integer  "height"
    t.string   "phone_number"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "coach"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "bodyweights", "preps"
  add_foreign_key "cardios", "preps"
  add_foreign_key "certifications", "users"
  add_foreign_key "contests", "preps"
  add_foreign_key "invitations", "preps"
  add_foreign_key "invitations", "users"
  add_foreign_key "macros", "preps"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
  add_foreign_key "philosophies", "users"
  add_foreign_key "photos", "preps"
  add_foreign_key "preps", "users"
  add_foreign_key "resourceries", "preps"
  add_foreign_key "resourceries", "resources"
  add_foreign_key "resources", "users"
  add_foreign_key "taggings", "photos"
  add_foreign_key "taggings", "tags"
  add_foreign_key "target_cardios", "preps"
  add_foreign_key "target_macros", "preps"
end
