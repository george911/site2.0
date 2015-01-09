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

ActiveRecord::Schema.define(version: 20150108055007) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bosses", force: true do |t|
    t.string   "title"
    t.integer  "job_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bosses", ["job_id"], name: "index_bosses_on_job_id", using: :btree

  create_table "comments", force: true do |t|
    t.text     "body"
    t.string   "author"
    t.boolean  "top"
    t.integer  "job_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["job_id"], name: "index_comments_on_job_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "educations", force: true do |t|
    t.string   "school"
    t.date     "enter_school"
    t.date     "leave_school"
    t.string   "major"
    t.string   "degree"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "uptonow"
  end

  add_index "educations", ["user_id"], name: "index_educations_on_user_id", using: :btree

  create_table "experiences", force: true do |t|
    t.string   "skill"
    t.integer  "year"
    t.integer  "job_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "experiences", ["job_id"], name: "index_experiences_on_job_id", using: :btree

  create_table "jobs", force: true do |t|
    t.string   "title"
    t.string   "addr"
    t.string   "city"
    t.string   "industry"
    t.integer  "commission"
    t.text     "role"
    t.text     "requirement"
    t.integer  "base_pay"
    t.integer  "month"
    t.string   "bonus"
    t.integer  "allowance"
    t.string   "stock"
    t.integer  "stock_num"
    t.date     "concall_date"
    t.integer  "user_id"
    t.string   "peer"
    t.text     "memo"
    t.text     "company_info"
    t.integer  "work_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", force: true do |t|
    t.string   "mobile"
    t.string   "email"
    t.string   "name"
    t.string   "title"
    t.string   "status"
    t.string   "city"
    t.integer  "talent_id"
    t.integer  "user_id"
    t.integer  "job_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "line_items", ["job_id"], name: "index_line_items_on_job_id", using: :btree
  add_index "line_items", ["user_id"], name: "index_line_items_on_user_id", using: :btree

  create_table "rates", force: true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "stars",         null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type", using: :btree
  add_index "rates", ["rater_id"], name: "index_rates_on_rater_id", using: :btree

  create_table "rating_caches", force: true do |t|
    t.integer  "cacheable_id"
    t.string   "cacheable_type"
    t.float    "avg",            null: false
    t.integer  "qty",            null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type", using: :btree

  create_table "reviews", force: true do |t|
    t.string   "author"
    t.integer  "author_id"
    t.boolean  "top"
    t.text     "body"
    t.integer  "rating"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "employer"
    t.string   "title"
  end

  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "subordinates", force: true do |t|
    t.string   "title"
    t.integer  "num"
    t.integer  "job_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subordinates", ["job_id"], name: "index_subordinates_on_job_id", using: :btree

  create_table "summaries", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "summaries", ["user_id"], name: "index_summaries_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "mobile"
    t.string   "user_name"
    t.string   "true_name"
    t.string   "user_type"
    t.integer  "base_salary"
    t.integer  "month_num"
    t.integer  "bonus"
    t.integer  "housing"
    t.integer  "transport"
    t.string   "stock"
    t.integer  "stock_num"
    t.integer  "retention_bonus"
    t.integer  "expect_package"
    t.integer  "expect_month_salary"
    t.date     "birthday"
    t.string   "city"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "industry"
    t.string   "focus_job1"
    t.string   "focus_job2"
    t.string   "focus_job3"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "works", force: true do |t|
    t.string   "title"
    t.string   "employer"
    t.string   "industry"
    t.date     "join_date"
    t.date     "leave_date"
    t.text     "job_scope"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "uptonow"
  end

  add_index "works", ["user_id"], name: "index_works_on_user_id", using: :btree

end
