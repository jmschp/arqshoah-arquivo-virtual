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

ActiveRecord::Schema[7.0].define(version: 2022_06_24_182842) do
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

  create_table "book_authors", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_book_authors_on_author_id"
    t.index ["book_id"], name: "index_book_authors_on_book_id"
  end

  create_table "book_categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_book_categories_on_name", unique: true
  end

  create_table "book_fields", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_book_fields_on_name", unique: true
  end

  create_table "book_iconographies", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "iconography_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_book_iconographies_on_book_id"
    t.index ["iconography_id"], name: "index_book_iconographies_on_iconography_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "registration"
    t.string "title", null: false
    t.string "subtitle"
    t.integer "edition"
    t.string "isbn"
    t.integer "pages"
    t.integer "publishing_year"
    t.string "location"
    t.string "city"
    t.string "state"
    t.string "country"
    t.float "latitude"
    t.float "longitude"
    t.bigint "book_category_id", null: false
    t.bigint "book_field_id", null: false
    t.bigint "language_id"
    t.bigint "publishing_company_id"
    t.tsvector "document_ts_vector"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_category_id"], name: "index_books_on_book_category_id"
    t.index ["book_field_id"], name: "index_books_on_book_field_id"
    t.index ["language_id"], name: "index_books_on_language_id"
    t.index ["publishing_company_id"], name: "index_books_on_publishing_company_id"
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

  create_table "education_categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_education_categories_on_name", unique: true
  end

  create_table "education_organizers", force: :cascade do |t|
    t.bigint "education_id", null: false
    t.bigint "organizer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["education_id"], name: "index_education_organizers_on_education_id"
    t.index ["organizer_id"], name: "index_education_organizers_on_organizer_id"
  end

  create_table "education_promoter_institutions", force: :cascade do |t|
    t.bigint "education_id", null: false
    t.bigint "promoter_institution_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["education_id"], name: "index_education_promoter_institutions_on_education_id"
    t.index ["promoter_institution_id"], name: "index_edu_promo_inst_on_promoter_institution_id"
  end

  create_table "education_supporters", force: :cascade do |t|
    t.string "donor_type", null: false
    t.bigint "donor_id", null: false
    t.bigint "education_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["donor_type", "donor_id"], name: "index_education_supporters_on_donor"
    t.index ["education_id"], name: "index_education_supporters_on_education_id"
  end

  create_table "educations", force: :cascade do |t|
    t.string "registration"
    t.string "title", null: false
    t.string "target_public"
    t.date "start_date"
    t.date "end_date"
    t.boolean "online", default: false, null: false
    t.bigint "education_category_id", null: false
    t.bigint "venue_id"
    t.tsvector "document_ts_vector"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["education_category_id"], name: "index_educations_on_education_category_id"
    t.index ["venue_id"], name: "index_educations_on_venue_id"
  end

  create_table "iconographies", force: :cascade do |t|
    t.string "registration"
    t.string "title", null: false
    t.string "subtitle"
    t.date "date"
    t.integer "date_day"
    t.integer "date_month"
    t.integer "date_year"
    t.string "location"
    t.float "latitude"
    t.float "longitude"
    t.string "city"
    t.string "state"
    t.string "country"
    t.boolean "original"
    t.string "donor_type"
    t.bigint "donor_id"
    t.bigint "iconography_type_id", null: false
    t.bigint "iconography_technic_id", null: false
    t.bigint "iconography_support_id", null: false
    t.bigint "author_id"
    t.tsvector "document_ts_vector"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_iconographies_on_author_id"
    t.index ["document_ts_vector"], name: "index_iconographies_on_document_ts_vector", using: :gin
    t.index ["donor_type", "donor_id"], name: "index_iconographies_on_donor"
    t.index ["iconography_support_id"], name: "index_iconographies_on_iconography_support_id"
    t.index ["iconography_technic_id"], name: "index_iconographies_on_iconography_technic_id"
    t.index ["iconography_type_id"], name: "index_iconographies_on_iconography_type_id"
  end

  create_table "iconography_supports", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_iconography_supports_on_name", unique: true
  end

  create_table "iconography_technics", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_iconography_technics_on_name", unique: true
  end

  create_table "iconography_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_iconography_types_on_name", unique: true
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

  create_table "newspaper_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_newspaper_types_on_name", unique: true
  end

  create_table "newspapers", force: :cascade do |t|
    t.string "registration"
    t.string "title", null: false
    t.string "location"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "latitude"
    t.string "longitude"
    t.date "date"
    t.integer "date_day"
    t.integer "date_month"
    t.integer "date_year"
    t.string "print_number"
    t.bigint "newspaper_type_id", null: false
    t.bigint "author_id"
    t.bigint "agency_id"
    t.bigint "language_id"
    t.tsvector "document_ts_vector"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agency_id"], name: "index_newspapers_on_agency_id"
    t.index ["author_id"], name: "index_newspapers_on_author_id"
    t.index ["language_id"], name: "index_newspapers_on_language_id"
    t.index ["newspaper_type_id"], name: "index_newspapers_on_newspaper_type_id"
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

  create_table "teaching_material_authors", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.bigint "teaching_material_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_teaching_material_authors_on_author_id"
    t.index ["teaching_material_id"], name: "index_teaching_material_authors_on_teaching_material_id"
  end

  create_table "teaching_material_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_teaching_material_types_on_name", unique: true
  end

  create_table "teaching_materials", force: :cascade do |t|
    t.string "title", null: false
    t.integer "publication_year", null: false
    t.integer "pages"
    t.integer "recording_hours"
    t.string "recording_link"
    t.bigint "education_id", null: false
    t.bigint "teaching_material_type_id", null: false
    t.bigint "publishing_company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["education_id"], name: "index_teaching_materials_on_education_id"
    t.index ["publishing_company_id"], name: "index_teaching_materials_on_publishing_company_id"
    t.index ["teaching_material_type_id"], name: "index_teaching_materials_on_teaching_material_type_id"
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
  add_foreign_key "archives", "archive_classifications"
  add_foreign_key "archives", "archive_types"
  add_foreign_key "archives", "languages"
  add_foreign_key "archives", "organizations", column: "issuing_agency_id"
  add_foreign_key "archives", "organizations", column: "receiver_agency_id"
  add_foreign_key "book_authors", "books"
  add_foreign_key "book_authors", "people", column: "author_id"
  add_foreign_key "book_iconographies", "books"
  add_foreign_key "book_iconographies", "iconographies"
  add_foreign_key "books", "book_categories"
  add_foreign_key "books", "book_fields"
  add_foreign_key "books", "languages"
  add_foreign_key "books", "organizations", column: "publishing_company_id"
  add_foreign_key "citations", "people"
  add_foreign_key "education_organizers", "educations"
  add_foreign_key "education_organizers", "people", column: "organizer_id"
  add_foreign_key "education_promoter_institutions", "educations"
  add_foreign_key "education_promoter_institutions", "organizations", column: "promoter_institution_id"
  add_foreign_key "education_supporters", "educations"
  add_foreign_key "educations", "education_categories"
  add_foreign_key "educations", "organizations", column: "venue_id"
  add_foreign_key "iconographies", "iconography_supports"
  add_foreign_key "iconographies", "iconography_technics"
  add_foreign_key "iconographies", "iconography_types"
  add_foreign_key "iconographies", "people", column: "author_id"
  add_foreign_key "interviews", "people", column: "interviewed_id"
  add_foreign_key "interviews", "people", column: "interviewer_id"
  add_foreign_key "newspapers", "languages"
  add_foreign_key "newspapers", "newspaper_types"
  add_foreign_key "newspapers", "organizations", column: "agency_id"
  add_foreign_key "newspapers", "people", column: "author_id"
  add_foreign_key "people", "people", column: "father_id"
  add_foreign_key "people", "people", column: "mother_id"
  add_foreign_key "people", "people", column: "spouse_id"
  add_foreign_key "people", "religions"
  add_foreign_key "teaching_material_authors", "people", column: "author_id"
  add_foreign_key "teaching_material_authors", "teaching_materials"
  add_foreign_key "teaching_materials", "educations"
  add_foreign_key "teaching_materials", "organizations", column: "publishing_company_id"
  add_foreign_key "teaching_materials", "teaching_material_types"
end
