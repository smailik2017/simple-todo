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

ActiveRecord::Schema[7.0].define(version: 2022_05_17_141750) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", comment: "Коммунтарии пользователя к делам", force: :cascade do |t|
    t.text "content", comment: "Сщжержимое коментария"
    t.bigint "user_id", comment: "Внешний ключ для связи с таблицей USERS"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "commentable_type"
    t.bigint "commentable_id"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.date "deadline"
    t.bigint "task_id", null: false
    t.bigint "state_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_items_on_state_id"
    t.index ["task_id"], name: "index_items_on_task_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.boolean "active"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "users_count"
    t.string "code"
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tasks_count"
    t.integer "items_count"
    t.index ["name"], name: "index_states_on_name", unique: true
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.date "deadline"
    t.bigint "user_id", null: false
    t.bigint "state_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "items_count"
    t.index ["name"], name: "index_tasks_on_name", unique: true
    t.index ["state_id"], name: "index_tasks_on_state_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.boolean "active"
    t.bigint "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "settings", default: {}, comment: "Индивидуальные параметры пользователя"
    t.integer "state", comment: "Статусная модель пользователя"
    t.integer "tasks_count"
    t.integer "comments_count"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "comments", "users"
  add_foreign_key "items", "states"
  add_foreign_key "items", "tasks"
  add_foreign_key "tasks", "states"
  add_foreign_key "tasks", "users"
  add_foreign_key "users", "roles"
end
