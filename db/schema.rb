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

ActiveRecord::Schema.define(version: 2022_06_06_170234) do

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone"
    t.boolean "is_deleted"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "users_id"
    t.boolean "like"
    t.string "ssm"
    t.index ["users_id"], name: "index_customers_on_users_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "description"
    t.string "unit_price"
    t.string "unit"
    t.integer "sort_id"
    t.boolean "is_deleted"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "papers_id"
    t.integer "users_id"
    t.index ["papers_id"], name: "index_items_on_papers_id"
    t.index ["users_id"], name: "index_items_on_users_id"
  end

  create_table "papers", force: :cascade do |t|
    t.string "name"
    t.string "paper_type"
    t.string "price_unit"
    t.string "discount"
    t.string "deposit"
    t.boolean "is_deleted"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "users_id"
    t.integer "user_shops_id"
    t.integer "customers_id"
    t.string "comment"
    t.index ["customers_id"], name: "index_papers_on_customers_id"
    t.index ["user_shops_id"], name: "index_papers_on_user_shops_id"
    t.index ["users_id"], name: "index_papers_on_users_id"
  end

  create_table "user_shops", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "ssm"
    t.string "boss_name"
    t.string "boss_phone"
    t.string "nick_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "users_id"
    t.string "comment"
    t.index ["users_id"], name: "index_user_shops_on_users_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.boolean "is_deleted"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "words", force: :cascade do |t|
    t.string "cn"
    t.string "en"
    t.string "category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "users_id"
    t.index ["users_id"], name: "index_words_on_users_id"
  end

end
