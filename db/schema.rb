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

ActiveRecord::Schema[7.0].define(version: 2022_07_12_125404) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abouts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "page"
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

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

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "comments", comment: "Коммунтарии пользователя к делам", force: :cascade do |t|
    t.text "content", comment: "Сщжержимое коментария"
    t.bigint "user_id", comment: "Внешний ключ для связи с таблицей USERS"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "commentable_type"
    t.bigint "commentable_id"
    t.integer "parent_id", comment: "Ссылка на родительский комментарий"
    t.integer "lft", null: false, comment: "Левая граница множества в рамках гема awesome_nested_set"
    t.integer "rgt", null: false, comment: "Правая граница множества в рамках гема awesome_nested_set"
    t.integer "depth", default: 0, null: false, comment: "Глубина вложения узла в рамках гема awesome_nested_set"
    t.integer "children_count", default: 0, null: false, comment: "Колличество потомков в рамках гема awesome_nested_set"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["parent_id"], name: "index_comments_on_parent_id"
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
    t.boolean "done"
    t.integer "state_flag", comment: "Состояние задачи"
    t.index ["name"], name: "index_tasks_on_name", unique: true
    t.index ["state_id"], name: "index_tasks_on_state_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "traffic_lights", comment: "Светофоры города", force: :cascade do |t|
    t.string "address", comment: "Адрес установки светофора"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "state", comment: "Состояние AASM: красный, желтый, зеленый"
    t.boolean "active", default: true, comment: "true - включен, false - выключен"
  end

  create_table "tree_comments", comment: "Таблица замыканий для комментариев", force: :cascade do |t|
    t.integer "parent_id", comment: "Внешний ключ для родительского комментария"
    t.integer "child_id", comment: "Внешний ключ для ответа"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id", "child_id"], name: "index_tree_comments_on_parent_id_and_child_id", unique: true
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
    t.integer "state_flag", comment: "Состояние пользователя"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "users"
  add_foreign_key "items", "states"
  add_foreign_key "items", "tasks"
  add_foreign_key "tasks", "states"
  add_foreign_key "tasks", "users"
  add_foreign_key "users", "roles"
end
