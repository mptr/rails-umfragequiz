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

ActiveRecord::Schema.define(version: 2021_11_29_162159) do

  create_table "questions", force: :cascade do |t|
    t.string "type", null: false
    t.decimal "from"
    t.decimal "to"
    t.decimal "step"
    t.integer "up_to"
    t.string "answer_options"
    t.string "questions"
    t.boolean "optional", null: false
    t.string "description", null: false
    t.integer "survey_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["survey_id"], name: "index_questions_on_survey_id"
  end

  create_table "submission_sets", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "survey_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["survey_id"], name: "index_submission_sets_on_survey_id"
    t.index ["user_id"], name: "index_submission_sets_on_user_id"
  end

  create_table "submissions", force: :cascade do |t|
    t.string "type", null: false
    t.string "answer_string"
    t.decimal "answer_number"
    t.string "answers"
    t.integer "submission_set_id", null: false
    t.integer "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_submissions_on_question_id"
    t.index ["submission_set_id"], name: "index_submissions_on_submission_set_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string "name"
    t.datetime "from_date"
    t.datetime "to_date"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_surveys_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "questions", "surveys"
  add_foreign_key "submission_sets", "surveys"
  add_foreign_key "submission_sets", "users"
  add_foreign_key "submissions", "questions"
  add_foreign_key "submissions", "submission_sets"
  add_foreign_key "surveys", "users"
end
