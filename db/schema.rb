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

ActiveRecord::Schema.define(version: 20130810215137) do

  create_table "ISBN_to_be_entered", force: true do |t|
    t.string  "isbn",     limit: 15,             null: false
    t.string  "location", limit: 50,             null: false
    t.integer "count",    limit: 8,  default: 0, null: false
  end

  create_table "author", force: true do |t|
    t.integer "title_id"
    t.string  "author_name"
  end

  add_index "author", ["author_name"], name: "author_name", using: :btree
  add_index "author", ["author_name"], name: "author_name_2", unique: true, using: :btree
  add_index "author", ["title_id"], name: "title_id", using: :btree

  create_table "author_title", force: true do |t|
    t.integer "author_id"
    t.integer "title_id"
  end

  add_index "author_title", ["author_id", "title_id"], name: "unique_author_title", unique: true, using: :btree
  add_index "author_title", ["author_id"], name: "author_id", using: :btree
  add_index "author_title", ["title_id"], name: "title_id", using: :btree

  create_table "book", force: true do |t|
    t.decimal "listprice",                      precision: 10, scale: 2, default: 0.0
    t.float   "ourprice",                                                default: 0.0
    t.string  "consignment_status"
    t.date    "inventoried_when"
    t.string  "type",               limit: 50
    t.string  "location",           limit: 50,                           default: " ", null: false
    t.integer "location_id"
    t.string  "status"
    t.string  "distributor",        limit: 127,                          default: " ", null: false
    t.integer "title_id"
    t.date    "sold_when"
    t.string  "owner"
    t.string  "notes"
    t.float   "wholesale"
  end

  add_index "book", ["location_id"], name: "location_id", using: :btree
  add_index "book", ["status"], name: "status", using: :btree
  add_index "book", ["title_id"], name: "title_id", using: :btree

  create_table "book_images", force: true do |t|
    t.string   "image_file"
    t.integer  "title_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_inventory", force: true do |t|
    t.string "isbn",     limit: 15, null: false
    t.string "location", limit: 50, null: false
  end

  add_index "book_inventory", ["isbn"], name: "isbn", using: :btree

  create_table "cashbox", id: false, force: true do |t|
    t.float    "amount"
    t.datetime "date"
  end

  create_table "category", force: true do |t|
    t.integer "title_id"
    t.string  "category_name", default: " ", null: false
  end

  create_table "cd", force: true do |t|
    t.string "isbn", limit: 15, null: false
  end

  add_index "cd", ["isbn"], name: "isbn", using: :btree

  create_table "cover", force: true do |t|
    t.string "isbn",     limit: 15, null: false
    t.string "location", limit: 50, null: false
  end

  add_index "cover", ["isbn"], name: "isbn", using: :btree

  create_table "kind", force: true do |t|
    t.string "kind_name"
  end

  create_table "location", force: true do |t|
    t.string "location_name", limit: 128, default: " ", null: false
  end

  add_index "location", ["location_name"], name: "location", using: :btree
  add_index "location", ["location_name"], name: "location_name", using: :btree

  create_table "music", force: true do |t|
    t.string "isbn",     limit: 15, null: false
    t.string "location", limit: 50, null: false
  end

  add_index "music", ["isbn"], name: "isbn", using: :btree

  create_table "notes", force: true do |t|
    t.text     "message"
    t.string   "author",      limit: 32
    t.datetime "whenEntered"
  end

  create_table "ranked_database", force: true do |t|
    t.integer "title_id"
    t.string  "isbn",      limit: 15
    t.integer "kind_id"
    t.float   "listprice"
    t.integer "book_id"
    t.integer "RANK"
  end

  add_index "ranked_database", ["isbn"], name: "isbn", using: :btree
  add_index "ranked_database", ["title_id"], name: "title_id", using: :btree

  create_table "ranked_inventory", force: true do |t|
    t.string  "isbn",     limit: 15
    t.string  "location", limit: 50, null: false
    t.integer "RANK",     limit: 8
  end

  add_index "ranked_inventory", ["isbn"], name: "isbn", using: :btree

  create_table "special_order", force: true do |t|
    t.date   "date_ordered",                                   null: false
    t.string "customer_name",         limit: 64,  default: ""
    t.string "customer_phone_number", limit: 32
    t.string "customer_email",        limit: 254, default: ""
    t.text   "customer_order"
    t.text   "other_notes"
  end

  create_table "status", force: true do |t|
    t.string "status", limit: 8, null: false
  end

  create_table "title", force: true do |t|
    t.string  "isbn",         limit: 13, default: " ", null: false
    t.text    "booktitle"
    t.string  "publisher",    limit: 50, default: " ", null: false
    t.string  "release_date"
    t.text    "tag"
    t.integer "kind_id"
    t.integer "edition"
    t.string  "type",         limit: 25
    t.string  "isbn13",       limit: 13
  end

  add_index "title", ["booktitle"], name: "booktitle", length: {"booktitle"=>25}, using: :btree
  add_index "title", ["isbn"], name: "isbn", using: :btree
  add_index "title", ["kind_id"], name: "kind_id", using: :btree

  create_table "title_special_order", force: true do |t|
    t.integer "title_id",                                 null: false
    t.integer "special_order_id",                         null: false
    t.string  "order_status",     limit: 16, default: "", null: false
    t.date    "placed_when"
    t.date    "ordered_when"
    t.date    "arrived_when"
    t.date    "finished_when"
  end

  add_index "title_special_order", ["order_status"], name: "order_status", using: :btree
  add_index "title_special_order", ["special_order_id"], name: "special_order_id", using: :btree
  add_index "title_special_order", ["title_id"], name: "title_id", using: :btree

  create_table "transactionLog", force: true do |t|
    t.string   "action"
    t.float    "amount"
    t.datetime "date"
    t.string   "cashier"
    t.binary   "info"
    t.string   "schedule"
    t.string   "owner"
    t.string   "paid_how", limit: 20
    t.string   "cart_id",  limit: 40
  end

  create_table "type", force: true do |t|
    t.string "type_name"
  end

end
