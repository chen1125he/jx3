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

ActiveRecord::Schema.define(version: 20180416054456) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.boolean  "deleted",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "prices", force: :cascade do |t|
    t.integer  "product_id"
    t.decimal  "amount",      precision: 12, scale: 4
    t.string   "seller_name"
    t.datetime "record_time"
    t.boolean  "deleted",                              default: false
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
  end

  create_table "product_to_products", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "required_id"
    t.integer  "amount",      default: 1
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "deleted",     default: false
  end

  create_table "products", force: :cascade do |t|
    t.integer  "category_id"
    t.string   "game_id"
    t.string   "name"
    t.boolean  "deleted",                               default: false
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.decimal  "avg_amount",   precision: 12, scale: 4, default: "1.0"
    t.boolean  "compile_flag",                          default: false
    t.decimal  "vigor_cost",   precision: 6,  scale: 2
    t.decimal  "price",        precision: 12, scale: 4
  end

end
