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

ActiveRecord::Schema.define(version: 2019_03_15_083139) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "areas", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "chart_items", force: :cascade do |t|
    t.bigint "chart_id"
    t.string "item_type"
    t.bigint "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chart_id"], name: "index_chart_items_on_chart_id"
    t.index ["item_type", "item_id"], name: "index_chart_items_on_item_type_and_item_id"
  end

  create_table "charts", force: :cascade do |t|
    t.string "name"
    t.string "chart_type"
    t.string "item_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prices", force: :cascade do |t|
    t.bigint "owner_id"
    t.bigint "service_id"
    t.string "price_type", comment: "是否是固定的，否则有价格历史"
    t.string "currency_type", comment: "价格的货币类型"
    t.decimal "amount", precision: 12, scale: 4, default: "0.0"
    t.string "seller_name", comment: "售卖者"
    t.date "record_date", comment: "此价格的时间"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_prices_on_owner_id"
    t.index ["service_id"], name: "index_prices_on_service_id"
  end

  create_table "product_tags", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_tags_on_product_id"
    t.index ["tag_id"], name: "index_product_tags_on_tag_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "category_id"
    t.string "game_id"
    t.string "name"
    t.float "avg_amount", default: 1.0, comment: "平均获得数量(如生活技能物品)"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string "price_type", comment: "默认使用的价格类型"
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "requirements", force: :cascade do |t|
    t.bigint "owner_id"
    t.bigint "material_id"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_id"], name: "index_requirements_on_material_id"
    t.index ["owner_id"], name: "index_requirements_on_owner_id"
  end

  create_table "services", force: :cascade do |t|
    t.bigint "area_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["area_id"], name: "index_services_on_area_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "chart_items", "charts"
  add_foreign_key "prices", "products", column: "owner_id"
  add_foreign_key "product_tags", "products"
  add_foreign_key "product_tags", "tags"
  add_foreign_key "products", "categories"
  add_foreign_key "requirements", "products", column: "material_id"
  add_foreign_key "requirements", "products", column: "owner_id"
  add_foreign_key "services", "areas"
end
