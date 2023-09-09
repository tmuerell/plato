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

ActiveRecord::Schema[7.0].define(version: 2023_09_09_203918) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "api_tokens", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "token"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_api_tokens_on_token", unique: true
    t.index ["user_id"], name: "index_api_tokens_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.integer "ticket_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "creator_id", null: false
    t.index ["creator_id"], name: "index_comments_on_creator_id"
    t.index ["ticket_id"], name: "index_comments_on_ticket_id"
  end

  create_table "notification_configs", force: :cascade do |t|
    t.string "delivery_type"
    t.integer "project_id", null: false
    t.string "filter"
    t.string "email_recepient_to"
    t.string "email_recepient_bcc"
    t.string "pager_duty_service_key"
    t.string "zulip_url"
    t.string "zulip_username"
    t.string "zulip_password"
    t.string "zulip_stream"
    t.string "zulip_topic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_notification_configs_on_project_id"
  end

  create_table "project_group_mappings", force: :cascade do |t|
    t.integer "project_id", null: false
    t.string "group"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_group_mappings_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "shortname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "workflow"
    t.index ["shortname"], name: "index_projects_on_shortname", unique: true
  end

  create_table "tag_groups", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "project_id", null: false
    t.decimal "min_count"
    t.decimal "max_count"
    t.index ["project_id", "name"], name: "index_tag_groups_on_project_id_and_name", unique: true
    t.index ["project_id"], name: "index_tag_groups_on_project_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "taggable_id"
    t.string "taggable_type"
    t.integer "user_id"
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "value"
    t.decimal "number_value"
    t.date "date_value"
    t.integer "user_value_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["user_id"], name: "index_taggings_on_user_id"
    t.index ["user_value_id"], name: "index_taggings_on_user_value_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "project_id", null: false
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.integer "tag_group_id"
    t.string "value_type"
    t.index ["project_id"], name: "index_tags_on_project_id"
    t.index ["tag_group_id"], name: "index_tags_on_tag_group_id"
  end

  create_table "ticket_ticket_relationships", force: :cascade do |t|
    t.integer "parent_id", null: false
    t.integer "child_id", null: false
    t.string "relationship"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_ticket_ticket_relationships_on_child_id"
    t.index ["parent_id"], name: "index_ticket_ticket_relationships_on_parent_id"
  end

  create_table "ticket_transitions", force: :cascade do |t|
    t.integer "ticket_id", null: false
    t.string "from"
    t.string "to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "duration"
    t.index ["ticket_id"], name: "index_ticket_transitions_on_ticket_id"
  end

  create_table "ticket_user_relationships", force: :cascade do |t|
    t.integer "ticket_id", null: false
    t.integer "user_id", null: false
    t.string "relationship"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_ticket_user_relationships_on_ticket_id"
    t.index ["user_id"], name: "index_ticket_user_relationships_on_user_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "sequential_id"
    t.text "title"
    t.text "content"
    t.integer "project_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "creator_id", null: false
    t.integer "assignee_id"
    t.string "external_id"
    t.datetime "last_transition_at"
    t.text "identifier", null: false
    t.index ["assignee_id"], name: "index_tickets_on_assignee_id"
    t.index ["creator_id"], name: "index_tickets_on_creator_id"
    t.index ["identifier"], name: "index_tickets_on_identifier"
  end

  create_table "user_project_roles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "project_id", null: false
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_user_project_roles_on_project_id"
    t.index ["user_id"], name: "index_user_project_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "firstname"
    t.string "lastname"
    t.text "roles"
    t.integer "current_project_id"
    t.text "groups"
    t.index ["current_project_id"], name: "index_users_on_current_project_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object", limit: 1073741823
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "api_tokens", "users"
  add_foreign_key "comments", "tickets"
  add_foreign_key "comments", "users", column: "creator_id"
  add_foreign_key "notification_configs", "projects"
  add_foreign_key "project_group_mappings", "projects"
  add_foreign_key "tag_groups", "projects"
  add_foreign_key "taggings", "tags"
  add_foreign_key "taggings", "users"
  add_foreign_key "taggings", "users", column: "user_value_id"
  add_foreign_key "tags", "projects"
  add_foreign_key "ticket_ticket_relationships", "tickets", column: "child_id"
  add_foreign_key "ticket_ticket_relationships", "tickets", column: "parent_id"
  add_foreign_key "ticket_transitions", "tickets"
  add_foreign_key "ticket_user_relationships", "tickets"
  add_foreign_key "ticket_user_relationships", "users"
  add_foreign_key "tickets", "projects"
  add_foreign_key "tickets", "users", column: "assignee_id"
  add_foreign_key "tickets", "users", column: "creator_id"
  add_foreign_key "user_project_roles", "projects"
  add_foreign_key "user_project_roles", "users"
  add_foreign_key "users", "projects", column: "current_project_id"
end
