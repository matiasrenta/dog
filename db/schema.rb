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

ActiveRecord::Schema.define(version: 20200626155909) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "api_keys", force: :cascade do |t|
    t.string   "application"
    t.string   "access_token"
    t.text     "note"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.boolean  "access_only_with_token"
  end

  create_table "api_users", force: :cascade do |t|
    t.string   "name"
    t.integer  "role_id"
    t.string   "locale"
    t.string   "time_zone"
    t.string   "avatar_id"
    t.string   "avatar_filename"
    t.integer  "avatar_size"
    t.string   "avatar_content_type"
    t.datetime "last_seen_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "api_users", ["confirmation_token"], name: "index_api_users_on_confirmation_token", unique: true, using: :btree
  add_index "api_users", ["email"], name: "index_api_users_on_email", unique: true, using: :btree
  add_index "api_users", ["reset_password_token"], name: "index_api_users_on_reset_password_token", unique: true, using: :btree

  create_table "boxes", force: :cascade do |t|
    t.string   "name"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "boxes_products", id: false, force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "box_id",     null: false
  end

  add_index "boxes_products", ["box_id", "product_id"], name: "index_boxes_products_on_box_id_and_product_id", using: :btree
  add_index "boxes_products", ["product_id", "box_id"], name: "index_boxes_products_on_product_id_and_box_id", using: :btree

  create_table "chucky_bot_fields", force: :cascade do |t|
    t.string   "name"
    t.string   "field_type"
    t.string   "i18n_name"
    t.text     "formats_options"
    t.text     "validations_options"
    t.text     "association_options"
    t.integer  "chucky_bot_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "chucky_bots", force: :cascade do |t|
    t.string   "underscore_model_name"
    t.string   "i18n_singular_name"
    t.string   "i18n_plural_name"
    t.text     "authorization"
    t.text     "public_activity"
    t.boolean  "migrate"
    t.text     "chucky_command"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "fa_icon"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "title"
    t.text     "body"
    t.string   "subject"
    t.integer  "user_id",          null: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "customer_branches", force: :cascade do |t|
    t.integer  "customer_id"
    t.string   "name"
    t.string   "address"
    t.text     "notes"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "customer_categories", force: :cascade do |t|
    t.string   "name"
    t.decimal  "company_profit_percent",               precision: 10, scale: 2
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.decimal  "seller_profit_percent",                precision: 10, scale: 2
    t.decimal  "seller_commission_over_price_percent", precision: 10, scale: 2
    t.decimal  "total_profit_percent",                 precision: 10, scale: 2
    t.integer  "order"
  end

  create_table "customer_contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "phones"
    t.string   "email"
    t.text     "notes"
    t.integer  "customer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.text     "notes"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "customer_category_id"
    t.integer  "user_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "inventories", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "lot"
    t.date     "expiration_date"
    t.integer  "box_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "quantity_available"
    t.integer  "quantity_available_in_units"
  end

  create_table "inventory_events", force: :cascade do |t|
    t.string   "event"
    t.string   "reason"
    t.text     "notes"
    t.integer  "entity_id"
    t.string   "entity_type"
    t.text     "entity_serialized"
    t.integer  "quantity"
    t.integer  "box_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "product_id"
    t.date     "expiration_date"
    t.integer  "quantity_count_by_human"
  end

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type", using: :btree

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree

  create_table "mix_box_details", force: :cascade do |t|
    t.integer  "mix_box_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_details", force: :cascade do |t|
    t.integer  "order_id"
    t.decimal  "unit_price",       precision: 10, scale: 2
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.decimal  "subtotal",         precision: 10, scale: 2
    t.integer  "quantity"
    t.integer  "stock_at_create"
    t.integer  "quantity_units"
    t.integer  "box_id"
    t.integer  "product_id"
    t.integer  "promotion_id"
    t.decimal  "disccount_amount", precision: 10, scale: 2
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "customer_id"
    t.integer  "user_id"
    t.decimal  "total_amount",       precision: 10, scale: 2
    t.string   "status"
    t.datetime "delivery_date"
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.integer  "customer_branch_id"
    t.boolean  "iva",                                         default: false
    t.decimal  "iva_amount",         precision: 10, scale: 2
  end

  create_table "prices", force: :cascade do |t|
    t.integer  "priceable_id"
    t.string   "priceable_type"
    t.integer  "customer_category_id"
    t.decimal  "company_profit_percent",               precision: 10, scale: 2
    t.decimal  "seller_profit_percent",                precision: 10, scale: 2
    t.decimal  "seller_commission_over_price_percent", precision: 10, scale: 2
    t.decimal  "price",                                precision: 10, scale: 2
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.decimal  "total_profit_percent",                 precision: 10, scale: 2
  end

  create_table "product_boxes", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "box_id"
    t.integer  "stock_min"
    t.integer  "stock_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_brands", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_prices", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "customer_category_id"
    t.decimal  "price",                precision: 10, scale: 2
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.decimal  "profit_percent",       precision: 10, scale: 2
    t.decimal  "sales_commission",     precision: 10, scale: 2
  end

  create_table "products", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.decimal  "product_cost",       precision: 10, scale: 2
    t.decimal  "cargo_cost",         precision: 10, scale: 2
    t.decimal  "total_cost",         precision: 10, scale: 2
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.boolean  "units_sale_allowed",                          default: false
    t.boolean  "is_mix_box",                                  default: false
    t.integer  "product_brand_id"
  end

  create_table "promotions", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "box_id"
    t.date     "expiration_date"
    t.integer  "quantity_start"
    t.integer  "quantity_available"
    t.date     "from_date"
    t.string   "end_with"
    t.date     "to_date"
    t.string   "name"
    t.text     "notes"
    t.string   "promo_type"
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.boolean  "published",                                   default: false
    t.decimal  "product_total_cost", precision: 10, scale: 2
  end

  create_table "purchase_order_details", force: :cascade do |t|
    t.integer  "box_id"
    t.integer  "quantity"
    t.decimal  "product_unit_cost", precision: 10, scale: 2
    t.decimal  "box_unit_cost",     precision: 10, scale: 2
    t.integer  "purchase_order_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "purchase_orders", force: :cascade do |t|
    t.integer  "supplier_id"
    t.decimal  "total_amount", precision: 10, scale: 2
    t.string   "status"
    t.text     "notes"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "list_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", force: :cascade do |t|
    t.string   "var",                    null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type",  limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "social_users", force: :cascade do |t|
    t.string   "provider"
    t.string   "email"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "name"
    t.text     "access_token"
    t.text     "json_data"
    t.integer  "uid",          limit: 8
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "thing_attaches", force: :cascade do |t|
    t.string   "file_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "thing_id"
    t.string   "file_filename"
    t.integer  "file_size"
    t.string   "file_content_type"
  end

  create_table "thing_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "thing_contacts", force: :cascade do |t|
    t.string   "name"
    t.integer  "thing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "field1"
    t.string   "field2"
    t.string   "field3"
  end

  create_table "thing_parts", force: :cascade do |t|
    t.string   "name"
    t.string   "field1"
    t.string   "field2"
    t.string   "field3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "things", force: :cascade do |t|
    t.string   "name"
    t.integer  "age"
    t.decimal  "price",             precision: 10, scale: 2
    t.date     "expires"
    t.datetime "discharged_at"
    t.text     "description"
    t.boolean  "published"
    t.string   "gender"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "thing_category_id"
    t.integer  "user_id"
  end

  create_table "things_thing_parts", id: false, force: :cascade do |t|
    t.integer "thing_id"
    t.integer "thing_part_id"
  end

  add_index "things_thing_parts", ["thing_id"], name: "index_things_thing_parts_on_thing_id", using: :btree
  add_index "things_thing_parts", ["thing_part_id"], name: "index_things_thing_parts_on_thing_part_id", using: :btree

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
    t.integer  "role_id"
    t.string   "name"
    t.integer  "failed_attempts"
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "locale"
    t.string   "time_zone"
    t.string   "avatar_id"
    t.string   "avatar_filename"
    t.integer  "avatar_size"
    t.string   "avatar_content_type"
    t.datetime "last_seen_at"
    t.datetime "deleted_at"
  end

  add_index "users", ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"

  create_view "inv_groupeds", sql_definition: <<-SQL
      SELECT sum(inventories.quantity_available) AS quantity_available,
      inventories.product_id,
      inventories.box_id
     FROM inventories
    GROUP BY inventories.product_id, inventories.box_id;
  SQL
end
