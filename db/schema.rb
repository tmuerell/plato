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

ActiveRecord::Schema[7.0].define(version: 2023_07_21_112549) do
  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.integer "ticket_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_comments_on_ticket_id"
  end

  create_table "customer_projects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "shortname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shortname"], name: "index_projects_on_shortname", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "project_id", null: false
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_tags_on_project_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "sequential_id"
    t.text "title"
    t.text "content"
    t.integer "project_id", null: false
    t.string "status"
    t.string "priority"
    t.integer "customer_project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_project_id"], name: "index_tickets_on_customer_project_id"
    t.index ["project_id"], name: "index_tickets_on_project_id"
  end

  add_foreign_key "comments", "tickets"
  add_foreign_key "tags", "projects"
  add_foreign_key "tickets", "customer_projects"
  add_foreign_key "tickets", "projects"
end
