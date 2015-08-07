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

ActiveRecord::Schema.define(version: 20150728072618) do

  create_table "attendance_logs", force: true do |t|
    t.integer  "office_id"
    t.datetime "date"
    t.integer  "enroll_id"
    t.integer  "in_out"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attendances", force: true do |t|
    t.integer  "employee_id"
    t.integer  "shift_id"
    t.datetime "date"
    t.integer  "status",      default: 1
    t.integer  "time_in"
    t.integer  "time_out"
    t.boolean  "is_late",     default: false
    t.integer  "late_minute", default: 0
    t.string   "description"
    t.boolean  "is_deleted",  default: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "banks", force: true do |t|
    t.integer  "office_id"
    t.string   "code"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bpjs_insurances", force: true do |t|
    t.integer  "employee_id"
    t.datetime "date"
    t.string   "no"
    t.decimal  "premi",       precision: 14, scale: 2, default: 0.0
    t.string   "description"
    t.boolean  "is_active",                            default: true
    t.boolean  "is_deleted",                           default: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bpjs_percentages", force: true do |t|
    t.integer  "office_id"
    t.decimal  "employee_percentage", precision: 14, scale: 2, default: 0.0
    t.decimal  "office_percentage",   precision: 14, scale: 2, default: 0.0
    t.integer  "max_of_children"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "branch_offices", force: true do |t|
    t.integer  "office_id"
    t.string   "code"
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "country"
    t.string   "postal_code"
    t.string   "phone"
    t.string   "fax"
    t.string   "website"
    t.string   "email"
    t.string   "npwp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "certificates", force: true do |t|
    t.integer  "employee_id"
    t.datetime "received_at"
    t.string   "location"
    t.string   "no_certificate"
    t.string   "receiver"
    t.boolean  "is_returned",    default: false
    t.datetime "returned_at"
    t.string   "giver"
    t.string   "description"
    t.boolean  "is_deleted"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commissions", force: true do |t|
    t.integer  "employee_id"
    t.datetime "date"
    t.decimal  "value",       precision: 14, scale: 2, default: 0.0
    t.string   "description"
    t.boolean  "is_deleted",                           default: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "day_offs", force: true do |t|
    t.integer  "office_id"
    t.integer  "overtime_id"
    t.datetime "date"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "decrees", force: true do |t|
    t.string   "no"
    t.datetime "date"
    t.integer  "employee_id"
    t.integer  "office_id"
    t.integer  "branch_office_id"
    t.integer  "department_id"
    t.integer  "division_id"
    t.integer  "title_id"
    t.integer  "sk_type"
    t.string   "description"
    t.boolean  "is_deleted",       default: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", force: true do |t|
    t.integer  "office_id"
    t.integer  "branch_office_id"
    t.string   "code"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "devices", force: true do |t|
    t.integer  "office_id"
    t.string   "ip_address"
    t.integer  "port"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "divisions", force: true do |t|
    t.integer  "office_id"
    t.integer  "branch_office_id"
    t.integer  "department_id"
    t.string   "code"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employee_contracts", force: true do |t|
    t.integer  "employee_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "no"
    t.string   "outsource_company"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employee_educations", force: true do |t|
    t.integer  "employee_id"
    t.integer  "level"
    t.string   "range_year"
    t.string   "majors"
    t.string   "school"
    t.string   "city"
    t.integer  "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employee_job_experiences", force: true do |t|
    t.integer  "employee_id"
    t.string   "company_name"
    t.string   "range_year"
    t.string   "last_job_title"
    t.float    "last_salary"
    t.string   "end_working_reason"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employee_offices", force: true do |t|
    t.integer  "employee_id"
    t.integer  "office_id"
    t.integer  "branch_office_id"
    t.integer  "department_id"
    t.integer  "division_id"
    t.integer  "title_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employee_relationships", force: true do |t|
    t.integer  "employee_id"
    t.string   "name"
    t.integer  "relationship"
    t.datetime "date_of_birth"
    t.string   "gender"
    t.string   "education"
    t.string   "employment"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employee_skills", force: true do |t|
    t.integer  "employee_id"
    t.string   "name"
    t.integer  "level"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employee_trainings", force: true do |t|
    t.integer  "employee_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "subject"
    t.string   "organizer"
    t.string   "place"
    t.string   "company"
    t.string   "result"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", force: true do |t|
    t.integer  "office_id"
    t.integer  "branch_office_id"
    t.integer  "department_id"
    t.integer  "division_id"
    t.integer  "title_id"
    t.integer  "level_id"
    t.integer  "status_working_id"
    t.string   "code"
    t.string   "full_name"
    t.string   "nick_name"
    t.integer  "enroll_id"
    t.string   "place_of_birth"
    t.datetime "date_of_birth"
    t.integer  "gender"
    t.integer  "religion"
    t.string   "address"
    t.string   "no_jamsostek",              default: ""
    t.datetime "jamsostek_registered_date", default: '2015-08-06 07:17:51'
    t.integer  "bank_id"
    t.string   "bank_account"
    t.string   "bank_account_name"
    t.datetime "start_working"
    t.string   "phone"
    t.string   "hp"
    t.string   "email"
    t.integer  "country"
    t.string   "identity_number"
    t.boolean  "is_not_active",             default: false
    t.datetime "not_active_at"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "general_leaves", force: true do |t|
    t.integer  "office_id"
    t.datetime "date"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jamsosteks", force: true do |t|
    t.integer  "office_id"
    t.string   "code"
    t.string   "name"
    t.decimal  "jkk_percentage",          precision: 14, scale: 2, default: 0.0
    t.decimal  "jkm_percentage",          precision: 14, scale: 2, default: 0.0
    t.decimal  "jht_employee_percentage", precision: 14, scale: 2, default: 0.0
    t.decimal  "jht_office_percentage",   precision: 14, scale: 2, default: 0.0
    t.decimal  "jp_employee_percentage",  precision: 14, scale: 2, default: 0.0
    t.decimal  "jp_office_percentage",    precision: 14, scale: 2, default: 0.0
    t.decimal  "jp_maximum_salary",       precision: 14, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", force: true do |t|
    t.integer  "employee_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "destination"
    t.string   "description"
    t.boolean  "is_deleted",  default: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leave_details", force: true do |t|
    t.integer  "employee_id"
    t.datetime "start_working"
    t.integer  "period_year"
    t.datetime "start_period"
    t.datetime "end_period"
    t.integer  "max_leave",     default: 0
    t.integer  "used_leave",    default: 0
    t.integer  "current_leave", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leaves", force: true do |t|
    t.integer  "employee_id"
    t.datetime "date"
    t.string   "description"
    t.boolean  "is_approved", default: false
    t.datetime "approved_at"
    t.boolean  "is_deleted",  default: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "levels", force: true do |t|
    t.integer  "office_id"
    t.string   "code"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loan_details", force: true do |t|
    t.integer  "loan_id"
    t.datetime "month"
    t.decimal  "amount",      precision: 14, scale: 2, default: 0.0
    t.boolean  "is_paid",                              default: false
    t.boolean  "is_closed",                            default: false
    t.boolean  "is_deleted",                           default: false
    t.datetime "deleted_at"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loans", force: true do |t|
    t.integer  "employee_id"
    t.datetime "date"
    t.decimal  "value",             precision: 14, scale: 2, default: 0.0
    t.decimal  "interest",          precision: 14, scale: 2, default: 0.0
    t.decimal  "total",             precision: 14, scale: 2, default: 0.0
    t.integer  "installment_time"
    t.decimal  "installment_value", precision: 14, scale: 2, default: 0.0
    t.datetime "installment_start"
    t.datetime "installment_end"
    t.string   "description"
    t.boolean  "is_deleted",                                 default: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offices", force: true do |t|
    t.string  "code"
    t.string  "name"
    t.string  "address"
    t.string  "city"
    t.string  "state"
    t.integer "country"
    t.string  "postal_code"
    t.string  "phone"
    t.string  "fax"
    t.string  "website"
    t.string  "email"
    t.string  "npwp"
    t.string  "director"
    t.string  "npwp_director"
  end

  create_table "other_expenses", force: true do |t|
    t.integer  "employee_id"
    t.datetime "date"
    t.boolean  "is_taxable",                           default: true
    t.decimal  "value",       precision: 14, scale: 2, default: 0.0
    t.string   "description"
    t.boolean  "is_deleted",                           default: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "other_incomes", force: true do |t|
    t.integer  "employee_id"
    t.datetime "date"
    t.boolean  "is_taxable",                           default: true
    t.decimal  "value",       precision: 14, scale: 2, default: 0.0
    t.string   "description"
    t.boolean  "is_deleted",                           default: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "overtime_allocations", force: true do |t|
    t.integer  "employee_id"
    t.integer  "overtime_id"
    t.datetime "date"
    t.integer  "start_time"
    t.integer  "end_time"
    t.string   "description"
    t.boolean  "is_approved", default: false
    t.datetime "approved_at"
    t.boolean  "is_deleted",  default: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "overtime_details", force: true do |t|
    t.integer  "overtime_id"
    t.float    "from_value"
    t.float    "to_value"
    t.float    "multiplier"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "overtimes", force: true do |t|
    t.integer  "office_id"
    t.string   "code"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payrolls", force: true do |t|
    t.integer  "office_id"
    t.datetime "month"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pkwts", force: true do |t|
    t.integer  "office_id"
    t.string   "no"
    t.boolean  "is_employee",        default: false
    t.integer  "employee_id"
    t.integer  "length_of_contract"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "description"
    t.boolean  "is_deleted",         default: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pkwtts", force: true do |t|
    t.integer  "office_id"
    t.string   "no"
    t.boolean  "is_employee",        default: false
    t.integer  "employee_id"
    t.integer  "length_of_contract"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "description"
    t.boolean  "is_deleted",         default: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pph21_details", force: true do |t|
    t.integer  "pph21_id"
    t.decimal  "percentage",  precision: 14, scale: 2, default: 0.0
    t.decimal  "from_value",  precision: 14, scale: 2, default: 0.0
    t.decimal  "to_value",    precision: 14, scale: 2, default: 0.0
    t.boolean  "is_up",                                default: false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pph21_non_employee_allocations", force: true do |t|
    t.integer  "pph21_non_employee_id"
    t.decimal  "bruto_value",           precision: 14, scale: 2, default: 0.0
    t.decimal  "dpp_value",             precision: 14, scale: 2, default: 0.0
    t.decimal  "prosen_dpp",            precision: 14, scale: 2, default: 0.0
    t.decimal  "prosen_pph",            precision: 14, scale: 2, default: 0.0
    t.decimal  "pph21_value",           precision: 14, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pph21_non_employees", force: true do |t|
    t.integer  "office_id"
    t.string   "nik"
    t.string   "name"
    t.string   "address"
    t.string   "npwp",               default: ""
    t.integer  "marital_status"
    t.integer  "number_of_children"
    t.integer  "tax_code_id"
    t.integer  "npwp_method",        default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pph21s", force: true do |t|
    t.integer  "office_id"
    t.string   "code"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "preferences", force: true do |t|
    t.integer  "office_id"
    t.decimal  "ot_divider",               precision: 14, scale: 2, default: 0.0
    t.decimal  "biaya_jabatan_percentage", precision: 14, scale: 2, default: 0.0
    t.decimal  "biaya_jabatan_max",        precision: 14, scale: 2, default: 0.0
    t.decimal  "pph_non_npwp_percentage",  precision: 14, scale: 2, default: 0.0
    t.decimal  "dpp_percentage",           precision: 14, scale: 2, default: 0.0
    t.integer  "pph21_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "private_leaves", force: true do |t|
    t.integer  "employee_id"
    t.datetime "date"
    t.integer  "start_time"
    t.integer  "end_time"
    t.string   "description"
    t.boolean  "is_approved", default: false
    t.datetime "approved_at"
    t.boolean  "is_deleted",  default: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ptkp_details", force: true do |t|
    t.integer  "ptkp_id"
    t.integer  "marital_status"
    t.integer  "number_of_children"
    t.decimal  "value",              precision: 14, scale: 2, default: 0.0
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ptkps", force: true do |t|
    t.integer  "office_id"
    t.string   "code"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recruitments", force: true do |t|
    t.string   "identity_number"
    t.string   "name"
    t.string   "place_of_birth"
    t.datetime "date_of_birth"
    t.integer  "gender"
    t.integer  "religion"
    t.string   "phone"
    t.string   "address"
    t.integer  "office_id"
    t.integer  "branch_office_id"
    t.integer  "department_id"
    t.integer  "division_id"
    t.integer  "title_id"
    t.integer  "level_id"
    t.integer  "status_working_id"
    t.datetime "date_application"
    t.datetime "date_psikotest"
    t.datetime "date_interview"
    t.string   "description"
    t.boolean  "is_bank_data",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shift_allocations", force: true do |t|
    t.integer  "shift_id"
    t.integer  "employee_id"
    t.boolean  "is_deleted",  default: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shift_details", force: true do |t|
    t.integer  "shift_id"
    t.integer  "day_code"
    t.integer  "start_time"
    t.integer  "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shifts", force: true do |t|
    t.integer  "office_id"
    t.string   "code"
    t.string   "name"
    t.integer  "start_time"
    t.integer  "duration"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "status_workings", force: true do |t|
    t.integer  "office_id"
    t.string   "code"
    t.string   "name"
    t.boolean  "is_contract", default: true
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tax_codes", force: true do |t|
    t.integer  "office_id"
    t.string   "code"
    t.string   "name"
    t.boolean  "is_final",    default: false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "terminations", force: true do |t|
    t.integer  "employee_id"
    t.datetime "date"
    t.string   "description"
    t.boolean  "is_approved", default: false
    t.datetime "approved_at"
    t.boolean  "is_deleted",  default: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "thrs", force: true do |t|
    t.integer  "employee_id"
    t.datetime "date"
    t.decimal  "value",       precision: 14, scale: 2, default: 0.0
    t.string   "description"
    t.boolean  "is_deleted",                           default: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "titles", force: true do |t|
    t.integer  "office_id"
    t.string   "code"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "training_details", force: true do |t|
    t.integer  "training_id"
    t.integer  "employee_id"
    t.boolean  "is_deleted",  default: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trainings", force: true do |t|
    t.integer  "office_id"
    t.string   "subject"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "trainer"
    t.string   "location"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_level_privileges", force: true do |t|
    t.integer  "user_id"
    t.integer  "level_id"
    t.boolean  "is_allow",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_privileges", force: true do |t|
    t.integer  "user_id"
    t.integer  "menu_id"
    t.boolean  "is_allow_read",    default: false
    t.boolean  "is_allow_add",     default: false
    t.boolean  "is_allow_edit",    default: false
    t.boolean  "is_allow_delete",  default: false
    t.boolean  "is_allow_print",   default: false
    t.boolean  "is_allow_approve", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.integer  "office_id"
    t.string   "username"
    t.string   "password"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wage_taxations", force: true do |t|
    t.integer  "employee_id"
    t.datetime "effective_date"
    t.integer  "marital_status"
    t.integer  "number_of_children"
    t.integer  "tax_method"
    t.integer  "tax_code_id"
    t.string   "npwp"
    t.datetime "npwp_registered_date"
    t.string   "npwp_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wage_transactions", force: true do |t|
    t.integer  "employee_id"
    t.integer  "year"
    t.integer  "month"
    t.decimal  "basic_salary",                precision: 14, scale: 2, default: 0.0
    t.decimal  "seniority_allowance",         precision: 14, scale: 2, default: 0.0
    t.decimal  "functional_allowance",        precision: 14, scale: 2, default: 0.0
    t.decimal  "meal_allowance",              precision: 14, scale: 2, default: 0.0
    t.decimal  "transport_allowance",         precision: 14, scale: 2, default: 0.0
    t.decimal  "phone_allowance",             precision: 14, scale: 2, default: 0.0
    t.decimal  "medical_allowance",           precision: 14, scale: 2, default: 0.0
    t.decimal  "overtime",                    precision: 14, scale: 2, default: 0.0
    t.decimal  "pph21_allowance",             precision: 14, scale: 2, default: 0.0
    t.decimal  "other_allowance_taxable",     precision: 14, scale: 2, default: 0.0
    t.decimal  "other_allowance_non_taxable", precision: 14, scale: 2, default: 0.0
    t.decimal  "thr",                         precision: 14, scale: 2, default: 0.0
    t.decimal  "commission",                  precision: 14, scale: 2, default: 0.0
    t.decimal  "jkk",                         precision: 14, scale: 2, default: 0.0
    t.decimal  "jkm",                         precision: 14, scale: 2, default: 0.0
    t.decimal  "jht_company",                 precision: 14, scale: 2, default: 0.0
    t.decimal  "jp_company",                  precision: 14, scale: 2, default: 0.0
    t.decimal  "bpjs_company",                precision: 14, scale: 2, default: 0.0
    t.decimal  "other_expense_taxable",       precision: 14, scale: 2, default: 0.0
    t.decimal  "other_expense_non_taxable",   precision: 14, scale: 2, default: 0.0
    t.decimal  "loan",                        precision: 14, scale: 2, default: 0.0
    t.decimal  "cooperative_dues",            precision: 14, scale: 2, default: 0.0
    t.decimal  "jht_employee",                precision: 14, scale: 2, default: 0.0
    t.decimal  "jp_employee",                 precision: 14, scale: 2, default: 0.0
    t.decimal  "bpjs_employee",               precision: 14, scale: 2, default: 0.0
    t.decimal  "bruto",                       precision: 14, scale: 2, default: 0.0
    t.decimal  "biaya_jabatan",               precision: 14, scale: 2, default: 0.0
    t.decimal  "netto",                       precision: 14, scale: 2, default: 0.0
    t.decimal  "netto_yearly",                precision: 14, scale: 2, default: 0.0
    t.decimal  "ptkp",                        precision: 14, scale: 2, default: 0.0
    t.decimal  "pkp",                         precision: 14, scale: 2, default: 0.0
    t.decimal  "pph_yearly",                  precision: 14, scale: 2, default: 0.0
    t.decimal  "pph21_value",                 precision: 14, scale: 2, default: 0.0
    t.decimal  "pph21_non_npwp",              precision: 14, scale: 2, default: 0.0
    t.decimal  "sisa_gaji",                   precision: 14, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wages", force: true do |t|
    t.integer  "employee_id"
    t.datetime "effective_date"
    t.integer  "pph21_id"
    t.integer  "ptkp_id"
    t.integer  "jamsostek_id"
    t.boolean  "is_daily_basic",                                   default: false
    t.decimal  "basic_salary",            precision: 14, scale: 2, default: 0.0
    t.boolean  "is_daily_seniority",                               default: false
    t.decimal  "seniority_allowance",     precision: 14, scale: 2, default: 0.0
    t.boolean  "is_daily_functional",                              default: false
    t.decimal  "functional_allowance",    precision: 14, scale: 2, default: 0.0
    t.boolean  "is_daily_meal",                                    default: false
    t.decimal  "meal_allowance",          precision: 14, scale: 2, default: 0.0
    t.boolean  "is_daily_transport",                               default: false
    t.decimal  "transport_allowance",     precision: 14, scale: 2, default: 0.0
    t.boolean  "is_daily_communication",                           default: false
    t.decimal  "communication_allowance", precision: 14, scale: 2, default: 0.0
    t.boolean  "is_daily_medical",                                 default: false
    t.decimal  "medical_allowance",       precision: 14, scale: 2, default: 0.0
    t.boolean  "is_cooperative_member",                            default: false
    t.decimal  "cooperative_dues",        precision: 14, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
