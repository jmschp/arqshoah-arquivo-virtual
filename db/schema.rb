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

ActiveRecord::Schema[7.0].define(version: 2022_06_18_154654) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
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
    t.string "name", null: false
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
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["confirmation_token"], name: "index_admin_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_admin_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_admin_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_admin_users_on_invited_by"
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_admin_users_on_unlock_token", unique: true
  end

  create_table "archive_classifications", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_archive_classifications_on_name", unique: true
  end

  create_table "archive_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_archive_types_on_name", unique: true
  end

  create_table "archives", force: :cascade do |t|
    t.date "date"
    t.integer "date_day"
    t.integer "date_month"
    t.integer "date_year"
    t.integer "date_mask"
    t.string "document_number"
    t.string "document_code"
    t.tsvector "document_ts_vector"
    t.float "latitude"
    t.float "longitude"
    t.string "location"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "from_name"
    t.string "from_role"
    t.integer "page_count"
    t.string "registration"
    t.string "title", null: false
    t.string "to_name"
    t.string "to_role"
    t.bigint "archive_classification_id", null: false
    t.bigint "archive_type_id", null: false
    t.string "donor_type"
    t.bigint "donor_id"
    t.bigint "language_id"
    t.bigint "issuing_agency_id"
    t.bigint "receiver_agency_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["archive_classification_id"], name: "index_archives_on_archive_classification_id"
    t.index ["archive_type_id"], name: "index_archives_on_archive_type_id"
    t.index ["document_ts_vector"], name: "index_archives_on_document_ts_vector", using: :gin
    t.index ["donor_type", "donor_id"], name: "index_archives_on_donor"
    t.index ["issuing_agency_id"], name: "index_archives_on_issuing_agency_id"
    t.index ["language_id"], name: "index_archives_on_language_id"
    t.index ["receiver_agency_id"], name: "index_archives_on_receiver_agency_id"
    t.index ["title"], name: "index_archives_on_title", unique: true
  end

  create_table "citations", force: :cascade do |t|
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "person_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_citations_on_person_id"
    t.index ["record_type", "record_id"], name: "index_citations_on_record"
  end

  create_table "interviews", force: :cascade do |t|
    t.date "date"
    t.string "location"
    t.float "latitude"
    t.float "longitude"
    t.string "city"
    t.string "state"
    t.string "country"
    t.bigint "interviewer_id", null: false
    t.bigint "interviewed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["interviewed_id"], name: "index_interviews_on_interviewed_id"
    t.index ["interviewer_id"], name: "index_interviews_on_interviewer_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_languages_on_name", unique: true
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.string "location"
    t.float "latitude"
    t.float "longitude"
    t.string "city"
    t.string "state"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_organizations_on_name", unique: true
  end

  create_table "people", force: :cascade do |t|
    t.string "academic_formation"
    t.date "birth_date"
    t.integer "birth_date_day"
    t.integer "birth_date_month"
    t.integer "birth_date_year"
    t.integer "birth_date_mask"
    t.string "birth_place"
    t.string "birth_place_city"
    t.string "birth_place_state"
    t.string "birth_place_country"
    t.float "birth_place_latitude"
    t.float "birth_place_longitude"
    t.date "death_date"
    t.integer "death_date_day"
    t.integer "death_date_month"
    t.integer "death_date_year"
    t.integer "death_date_mask"
    t.string "death_place"
    t.string "death_place_city"
    t.string "death_place_state"
    t.string "death_place_country"
    t.float "death_place_latitude"
    t.float "death_place_longitude"
    t.tsvector "document_ts_vector"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "name_variation"
    t.integer "gender"
    t.string "registration"
    t.string "type"
    t.bigint "religion_id"
    t.bigint "spouse_id"
    t.bigint "mother_id"
    t.bigint "father_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["father_id"], name: "index_people_on_father_id"
    t.index ["mother_id"], name: "index_people_on_mother_id"
    t.index ["religion_id"], name: "index_people_on_religion_id"
    t.index ["spouse_id"], name: "index_people_on_spouse_id"
  end

  create_table "religions", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_religions_on_name", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.jsonb "object"
    t.datetime "created_at"
    t.jsonb "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "citations", "people"
  add_foreign_key "interviews", "people", column: "interviewed_id"
  add_foreign_key "interviews", "people", column: "interviewer_id"
  add_foreign_key "people", "people", column: "father_id"
  add_foreign_key "people", "people", column: "mother_id"
  add_foreign_key "people", "people", column: "spouse_id"
  add_foreign_key "people", "religions"
end
