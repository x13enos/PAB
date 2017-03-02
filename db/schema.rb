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

ActiveRecord::Schema.define(version: 20170302083425) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "creatures", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active"
    t.float    "challenge_rating"
    t.integer  "experience"
    t.string   "class_name"
    t.string   "alignment"
    t.integer  "size"
    t.integer  "reach"
    t.integer  "init"
    t.string   "sense"
    t.integer  "perception"
    t.string   "race"
    t.string   "type_name"
    t.text     "subtypes",                default: [],              array: true
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "armor_class"
    t.integer  "armor_class_touch"
    t.integer  "armor_class_flat_footed"
    t.string   "armor_class_description"
    t.integer  "hit_points"
    t.string   "hit_dice"
    t.string   "regeneration"
    t.integer  "fortitude"
    t.integer  "reflex"
    t.string   "will"
    t.string   "defensive_abilities"
    t.string   "damage_reduction"
    t.string   "immune"
    t.string   "resist"
    t.string   "spell_resistance"
  end

  create_table "traps", force: :cascade do |t|
    t.string   "name"
    t.integer  "challenge_rating"
    t.integer  "experience"
    t.string   "type_of_system"
    t.string   "reset"
    t.string   "trigger"
    t.text     "effect"
    t.text     "description"
    t.integer  "perception"
    t.integer  "disable_devise"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
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
    t.integer  "role"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
