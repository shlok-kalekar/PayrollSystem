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

ActiveRecord::Schema[7.0].define(version: 2023_02_17_085930) do
  create_table "attendances", force: :cascade do |t|
    t.date "current_month"
    t.integer "tot_work_days"
    t.integer "unpaid_leaves"
    t.decimal "attend_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "users_id"
    t.index ["users_id"], name: "index_attendances_on_users_id"
  end

  create_table "leaves", force: :cascade do |t|
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.string "leave_type", null: false
    t.text "leave_details"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "users_id"
    t.index ["users_id"], name: "index_leaves_on_users_id"
  end

  create_table "payslips", force: :cascade do |t|
    t.float "attendance_deductible"
    t.float "taxable_salary"
    t.float "tot_tax"
    t.float "payable_salary"
    t.date "slip_month"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "users_id"
    t.index ["users_id"], name: "index_payslips_on_users_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "role_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "users_id"
    t.index ["users_id"], name: "index_roles_on_users_id"
  end

  create_table "salaries", force: :cascade do |t|
    t.decimal "total_salary"
    t.date "salary_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "users_id"
    t.index ["users_id"], name: "index_salaries_on_users_id"
  end

  create_table "tax_deductions", force: :cascade do |t|
    t.string "deduct_type"
    t.float "amount_deduct"
    t.date "financial_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "users_id"
    t.index ["users_id"], name: "index_tax_deductions_on_users_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "gender_type"
    t.integer "phone_no"
    t.string "designation_type"
    t.string "city_name"
    t.date "join_date"
    t.integer "tot_paid_leaves"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "jti", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "attendances", "users", column: "users_id"
  add_foreign_key "leaves", "users", column: "users_id"
  add_foreign_key "payslips", "users", column: "users_id"
  add_foreign_key "roles", "users", column: "users_id"
  add_foreign_key "salaries", "users", column: "users_id"
  add_foreign_key "tax_deductions", "users", column: "users_id"
end
