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

ActiveRecord::Schema.define(version: 20160208160251) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "fuzzystrmatch"
  enable_extension "pg_trgm"

  create_table "courses", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.string   "language"
    t.string   "credits"
    t.integer  "university_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "syllabus_file_name"
    t.string   "syllabus_content_type"
    t.integer  "syllabus_file_size"
    t.datetime "syllabus_updated_at"
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
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "identities", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "image"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "dept"
    t.datetime "date_sent"
    t.datetime "date_due"
    t.datetime "date_received"
    t.string   "note"
    t.string   "program_sponsor"
    t.string   "program_name"
    t.string   "program_term"
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "status"
  end

  create_table "umd_courses", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.string   "designator"
    t.datetime "approved"
    t.string   "approved_by"
    t.string   "notes"
    t.string   "lib_eds",                  array: true
    t.string   "credits"
    t.integer  "review_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "universities", force: :cascade do |t|
    t.string   "name"
    t.string   "city"
    t.string   "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "image"
    t.string   "umnid"
    t.string   "major"
    t.string   "minor"
    t.string   "collegiate_unit"
    t.boolean  "admin"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
