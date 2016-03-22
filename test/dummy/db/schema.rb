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

ActiveRecord::Schema.define(version: 20160322062228) do

  create_table "homeland_nodes", force: :cascade do |t|
    t.string   "name",         limit: 255,             null: false
    t.string   "description",  limit: 255
    t.string   "color",        limit: 255
    t.integer  "sort",         limit: 4,   default: 0, null: false
    t.integer  "topics_count", limit: 4,   default: 0, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "homeland_nodes", ["sort"], name: "index_homeland_nodes_on_sort", using: :btree

  create_table "homeland_replies", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "topic_id",    limit: 4
    t.text     "body",        limit: 65535
    t.text     "body_html",   limit: 65535
    t.datetime "deleted_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "reply_to_id", limit: 4
  end

  add_index "homeland_replies", ["reply_to_id"], name: "index_homeland_replies_on_reply_to_id", using: :btree
  add_index "homeland_replies", ["topic_id"], name: "index_homeland_replies_on_topic_id", using: :btree
  add_index "homeland_replies", ["user_id"], name: "index_homeland_replies_on_user_id", using: :btree

  create_table "homeland_topics", force: :cascade do |t|
    t.integer  "node_id",            limit: 4,                 null: false
    t.integer  "user_id",            limit: 4,                 null: false
    t.string   "title",              limit: 255,               null: false
    t.text     "body",               limit: 65535
    t.text     "body_html",          limit: 65535
    t.integer  "last_reply_id",      limit: 4
    t.integer  "last_reply_user_id", limit: 4
    t.integer  "last_active_mark",   limit: 4,     default: 0, null: false
    t.datetime "replied_at"
    t.integer  "replies_count",      limit: 4,     default: 0, null: false
    t.datetime "deleted_at"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "homeland_topics", ["deleted_at"], name: "index_homeland_topics_on_deleted_at", using: :btree
  add_index "homeland_topics", ["last_active_mark", "deleted_at"], name: "index_homeland_topics_on_last_active_mark_and_deleted_at", using: :btree
  add_index "homeland_topics", ["node_id", "deleted_at"], name: "index_homeland_topics_on_node_id_and_deleted_at", using: :btree
  add_index "homeland_topics", ["node_id", "last_active_mark"], name: "index_homeland_topics_on_node_id_and_last_active_mark", using: :btree
  add_index "homeland_topics", ["user_id"], name: "index_homeland_topics_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
