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

ActiveRecord::Schema.define(version: 20140909161040) do

  create_table " n", force: true do |t|
    t.string   "type",                     limit: 1
    t.string   "reason",                   limit: 3
    t.string   "date",                     limit: 10
    t.string   "time",                     limit: 8
    t.integer  "minutes",                                                       default: 0,   null: false
    t.string   "production_date",          limit: 10
    t.string   "shift",                    limit: 1
    t.integer  "machine",                                                       default: 0,   null: false
    t.string   "order_number",             limit: 20
    t.string   "material",                 limit: 20
    t.string   "product_code",             limit: 20
    t.string   "customer_name",            limit: 30
    t.string   "work_order_nbr",           limit: 18
    t.string   "order_type",               limit: 1
    t.integer  "bundle",                                                        default: 0,   null: false
    t.integer  "quantity",                                                      default: 0,   null: false
    t.decimal  "item_length",                          precision: 10, scale: 3, default: 0.0, null: false
    t.string   "part_option",              limit: 1
    t.string   "part_number",              limit: 30
    t.string   "pattern",                  limit: 3
    t.decimal  "total_length",                         precision: 14, scale: 3, default: 0.0, null: false
    t.decimal  "footage",                              precision: 14, scale: 3, default: 0.0, null: false
    t.decimal  "hole_offset",                          precision: 8,  scale: 3, default: 0.0, null: false
    t.integer  "hole_count",                                                    default: 0,   null: false
    t.string   "inv_coil",                 limit: 16
    t.string   "coil_material",            limit: 20
    t.decimal  "coil_width",                           precision: 6,  scale: 3, default: 0.0, null: false
    t.decimal  "lbs_per_foot",                         precision: 7,  scale: 3, default: 0.0, null: false
    t.decimal  "cost_per_lbs",                         precision: 7,  scale: 2, default: 0.0, null: false
    t.string   "heat_number",              limit: 20
    t.string   "code_type",                limit: 1
    t.integer  "code_value",                                                    default: 0,   null: false
    t.string   "code_description",         limit: 30
    t.string   "code_exempt",              limit: 1
    t.string   "machine_status",           limit: 1
    t.decimal  "duration",                             precision: 8,  scale: 2, default: 0.0, null: false
    t.decimal  "runtime",                              precision: 8,  scale: 2, default: 0.0, null: false
    t.decimal  "downtime",                             precision: 8,  scale: 2, default: 0.0, null: false
    t.decimal  "exempt_time",                          precision: 8,  scale: 2, default: 0.0, null: false
    t.decimal  "good_footage",                         precision: 11, scale: 3, default: 0.0, null: false
    t.decimal  "scrap_footage",                        precision: 14, scale: 3, default: 0.0, null: false
    t.decimal  "exempt_scrap",                         precision: 14, scale: 3, default: 0.0, null: false
    t.decimal  "reclaimed",                            precision: 14, scale: 3, default: 0.0, null: false
    t.decimal  "actual_speed",                         precision: 8,  scale: 3, default: 0.0, null: false
    t.decimal  "target_speed",                         precision: 8,  scale: 3, default: 0.0, null: false
    t.integer  "employee_id",                                                   default: 0,   null: false
    t.string   "employee_name",            limit: 30
    t.string   "item_id",                  limit: 22
    t.integer  "list_id",                                                       default: 0,   null: false
    t.string   "list_text",                limit: 40
    t.string   "plant_name",               limit: 30
    t.string   "list_valid",               limit: 100
    t.integer  "code_responsibility_type",                                      default: 0,   null: false
    t.integer  "unknown",                                                                     null: false
    t.string   "bundle_code",              limit: 15
    t.datetime "created_at",                                                                  null: false
    t.datetime "updated_at"
    t.string   "processed",                limit: 1,                            default: "n", null: false
    t.string   "importfile",               limit: 100
  end

  add_index " n", ["material"], name: "material", using: :btree
  add_index " n", ["order_number"], name: "order_number", using: :btree
  add_index " n", ["product_code"], name: "profile", using: :btree
  add_index " n", ["production_date"], name: "production_date", using: :btree
  add_index " n", ["work_order_nbr"], name: "workorder_number", using: :btree

  create_table "allocations", force: true do |t|
    t.string   "company",         limit: 5
    t.integer  "item_masters_id"
    t.integer  "warehouses_id"
    t.string   "lotserial",       limit: 1
    t.integer  "lotserial_id"
    t.integer  "alloc_from"
    t.string   "alloc_from_type", limit: 5
    t.integer  "alloc_to"
    t.string   "alloc_to_type",   limit: 5
    t.decimal  "alloc_qty",                  precision: 12, scale: 4
    t.string   "alloc_uom",       limit: 5
    t.string   "alloc_type",      limit: 5
    t.string   "created_by",      limit: 25
    t.datetime "created_at",                                          null: false
    t.string   "updated_by",      limit: 25
    t.datetime "updated_at",                                          null: false
  end

  add_index "allocations", ["company", "alloc_from"], name: "alloc_from", using: :btree
  add_index "allocations", ["company", "alloc_to"], name: "alloc_to", using: :btree
  add_index "allocations", ["company", "item_masters_id"], name: "item", using: :btree
  add_index "allocations", ["company", "warehouses_id", "item_masters_id"], name: "itemwhse", using: :btree
  add_index "allocations", ["lotserial_id"], name: "lotserial", using: :btree

  create_table "bin_masters", force: true do |t|
    t.string  "company",          limit: 5
    t.integer "warehouses_id"
    t.integer "whse_zones_id"
    t.string  "bin",              limit: 15
    t.decimal "bin_width",                   precision: 10, scale: 2
    t.decimal "bin_depth",                   precision: 10, scale: 2
    t.decimal "bin_height",                  precision: 10, scale: 2
    t.decimal "max_weight",                  precision: 12, scale: 2
    t.integer "pallet_footprint"
    t.integer "pallet_stack"
    t.decimal "bin_x",                       precision: 10, scale: 2
    t.decimal "bin_y",                       precision: 10, scale: 2
    t.decimal "bin_z",                       precision: 10, scale: 2
    t.decimal "pick_sequence",               precision: 10, scale: 2
    t.boolean "qa_hold",                                              default: false
    t.boolean "active",                                               default: false
  end

  add_index "bin_masters", ["company", "warehouses_id", "bin"], name: "companywhsebin", unique: true, using: :btree

  create_table "coil_receipts", force: true do |t|
    t.string    "company",           limit: 30
    t.integer   "item_masters_id"
    t.string    "lot",               limit: 16
    t.string    "basemetal",         limit: 20
    t.decimal   "thickness",                    precision: 6,  scale: 2
    t.string    "coating",           limit: 5
    t.string    "grade",             limit: 5
    t.decimal   "width",                        precision: 8,  scale: 4
    t.string    "mill_coil_id",      limit: 16
    t.string    "processor_coil_id", limit: 16
    t.string    "heat_number",       limit: 20
    t.decimal   "lbsperfoot",                   precision: 9,  scale: 4
    t.decimal   "received_weight",              precision: 12, scale: 4
    t.decimal   "received_footage",             precision: 12, scale: 4
    t.string    "created_by",        limit: 25
    t.timestamp "created_at",                                                            null: false
    t.string    "updated_by",        limit: 25
    t.timestamp "updated_at",                                                            null: false
    t.timestamp "ams_sent_at",                                                           null: false
    t.boolean   "ams_sent",                                              default: false
    t.integer   "ext_id"
  end

  add_index "coil_receipts", ["company", "item_masters_id"], name: "companyitem", using: :btree
  add_index "coil_receipts", ["item_masters_id", "lot"], name: "lot", unique: true, using: :btree
  add_index "coil_receipts", ["item_masters_id"], name: "item", using: :btree

  create_table "companies", force: true do |t|
    t.string    "company",                limit: 5
    t.string    "company_name",           limit: 50
    t.string    "short_name",             limit: 25
    t.string    "street_address1",        limit: 50
    t.string    "street_address2",        limit: 50
    t.string    "street_address3",        limit: 50
    t.string    "street_city",            limit: 50
    t.string    "street_prov",            limit: 50
    t.string    "street_pcode",           limit: 20
    t.string    "street_country",         limit: 50
    t.string    "mail_address1",          limit: 50
    t.string    "mail_address2",          limit: 50
    t.string    "mail_address3",          limit: 50
    t.string    "mail_city",              limit: 50
    t.string    "mail_prov",              limit: 50
    t.string    "mail_pcode",             limit: 20
    t.string    "mail_country",           limit: 50
    t.string    "phone",                  limit: 20
    t.string    "fax",                    limit: 20
    t.string    "email",                  limit: 50
    t.string    "local_currency",         limit: 3
    t.string    "fed_tax_id",             limit: 20
    t.string    "prov_tax_id",            limit: 20
    t.string    "county_tax_id",          limit: 20
    t.string    "city_tax_id",            limit: 20
    t.string    "other_tax_id",           limit: 20
    t.string    "duns_number",            limit: 15
    t.string    "logo_file"
    t.string    "clr_wip_acct",           limit: 15
    t.string    "clr_payroll_acct",       limit: 15
    t.string    "clr_equip_acct",         limit: 15
    t.string    "clr_inv_acct",           limit: 15
    t.string    "clr_poaccr_acct",        limit: 15
    t.string    "clr_retainage_acct",     limit: 15
    t.string    "clr_retainearn_acct",    limit: 15
    t.string    "clr_exch_gainloss_acct", limit: 15
    t.string    "clr_sales_tax_acct",     limit: 15
    t.string    "ar_acct",                limit: 15
    t.string    "ar_discount_acct",       limit: 15
    t.string    "ar_adjustment_acct",     limit: 15
    t.string    "ar_holdback_acct",       limit: 15
    t.string    "sales_taxrecd_acct",     limit: 15
    t.string    "ar_def_bankacct",        limit: 15
    t.string    "ap_acct",                limit: 15
    t.string    "ap_discount_account",    limit: 15
    t.string    "ap_adjustment_acct",     limit: 15
    t.string    "sales_taxpaid_acct",     limit: 15
    t.string    "purchase_variance_acct", limit: 15
    t.string    "ap_holdback_acct",       limit: 15
    t.string    "ap_def_bankacct",        limit: 15
    t.string    "inv_stock_acct",         limit: 15
    t.string    "inv_nonstock_acct",      limit: 15
    t.string    "inv_return_loss_acct",   limit: 15
    t.string    "inv_xfer_acct",          limit: 15
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "ext_id"
  end

  add_index "companies", ["company"], name: "company", using: :btree
  add_index "companies", ["company_name"], name: "companyname", using: :btree
  add_index "companies", ["duns_number"], name: "duns", using: :btree
  add_index "companies", ["phone"], name: "phone", using: :btree
  add_index "companies", ["short_name"], name: "short_name", using: :btree
  add_index "companies", ["street_address1"], name: "streetaddress", using: :btree
  add_index "companies", ["street_city"], name: "city", using: :btree
  add_index "companies", ["street_prov", "street_city"], name: "prov_city", using: :btree
  add_index "companies", ["street_prov"], name: "prov", using: :btree

  create_table "cost_types", force: true do |t|
    t.string    "cost_type",   limit: 10
    t.string    "description", limit: 50
    t.string    "is_default",  limit: 45, default: "0"
    t.timestamp "created_at"
  end

  add_index "cost_types", ["cost_type"], name: "cost_type", using: :btree

  create_table "current_coils", force: true do |t|
    t.integer   "workstations_id"
    t.string    "workstation",       limit: 50
    t.integer   "inv_lots_id"
    t.string    "lot",               limit: 50
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "coil_complete",                default: false
    t.string    "smartcard",         limit: 20
    t.integer   "smartcard_reading"
    t.boolean   "is_active",                    default: true
    t.boolean   "processed",                    default: false
  end

  add_index "current_coils", ["inv_lots_id"], name: "coil", using: :btree
  add_index "current_coils", ["workstations_id", "lot", "is_active"], name: "coilactive", using: :btree
  add_index "current_coils", ["workstations_id"], name: "workstation", using: :btree

  create_table "eclipse_imports", force: true do |t|
    t.string    "type",                     limit: 1
    t.string    "reason",                   limit: 3
    t.string    "date",                     limit: 10
    t.string    "time",                     limit: 8
    t.integer   "minutes",                                                       default: 0,   null: false
    t.string    "production_date",          limit: 10
    t.string    "shift",                    limit: 1
    t.integer   "machine",                                                       default: 0,   null: false
    t.string    "order_number",             limit: 20
    t.string    "material",                 limit: 20
    t.string    "product_code",             limit: 20
    t.string    "customer_name",            limit: 30
    t.string    "work_order_nbr",           limit: 18
    t.string    "order_type",               limit: 1
    t.integer   "bundle",                                                        default: 0,   null: false
    t.integer   "quantity",                                                      default: 0,   null: false
    t.decimal   "item_length",                          precision: 10, scale: 3, default: 0.0, null: false
    t.string    "part_option",              limit: 1
    t.string    "part_number",              limit: 30
    t.string    "pattern",                  limit: 3
    t.decimal   "total_length",                         precision: 14, scale: 3, default: 0.0, null: false
    t.decimal   "footage",                              precision: 14, scale: 3, default: 0.0, null: false
    t.decimal   "hole_offset",                          precision: 8,  scale: 3, default: 0.0, null: false
    t.integer   "hole_count",                                                    default: 0,   null: false
    t.string    "inv_coil",                 limit: 16
    t.string    "coil_material",            limit: 20
    t.decimal   "coil_width",                           precision: 6,  scale: 3, default: 0.0, null: false
    t.decimal   "lbs_per_foot",                         precision: 7,  scale: 3, default: 0.0, null: false
    t.decimal   "cost_per_lbs",                         precision: 7,  scale: 2, default: 0.0, null: false
    t.string    "heat_number",              limit: 20
    t.string    "code_type",                limit: 1
    t.integer   "code_value",                                                    default: 0,   null: false
    t.string    "code_description",         limit: 30
    t.string    "code_exempt",              limit: 1
    t.string    "machine_status",           limit: 1
    t.decimal   "duration",                             precision: 8,  scale: 2, default: 0.0, null: false
    t.decimal   "runtime",                              precision: 8,  scale: 2, default: 0.0, null: false
    t.decimal   "downtime",                             precision: 8,  scale: 2, default: 0.0, null: false
    t.decimal   "exempt_time",                          precision: 8,  scale: 2, default: 0.0, null: false
    t.decimal   "good_footage",                         precision: 11, scale: 3, default: 0.0, null: false
    t.decimal   "scrap_footage",                        precision: 14, scale: 3, default: 0.0, null: false
    t.decimal   "exempt_scrap",                         precision: 14, scale: 3, default: 0.0, null: false
    t.decimal   "reclaimed",                            precision: 14, scale: 3, default: 0.0, null: false
    t.decimal   "actual_speed",                         precision: 8,  scale: 3, default: 0.0, null: false
    t.decimal   "target_speed",                         precision: 8,  scale: 3, default: 0.0, null: false
    t.integer   "employee_id",                                                   default: 0,   null: false
    t.string    "employee_name",            limit: 30
    t.string    "item_id",                  limit: 22
    t.decimal   "list_id",                              precision: 10, scale: 3, default: 0.0, null: false
    t.string    "list_text",                limit: 40
    t.string    "plant_name",               limit: 30
    t.string    "list_valid",               limit: 100
    t.integer   "code_responsibility_type",                                      default: 0,   null: false
    t.string    "unknown",                  limit: 50,                           default: " ", null: false
    t.string    "bundle_code",              limit: 15
    t.timestamp "created_at",                                                                  null: false
    t.timestamp "updated_at"
    t.string    "processed",                limit: 1,                            default: "n", null: false
    t.string    "importfile",               limit: 100
    t.integer   "ext_id"
  end

  add_index "eclipse_imports", ["material"], name: "material", using: :btree
  add_index "eclipse_imports", ["order_number"], name: "ordernumber", using: :btree
  add_index "eclipse_imports", ["product_code"], name: "profile", using: :btree
  add_index "eclipse_imports", ["production_date"], name: "production_date", using: :btree

  create_table "gl_accounts", force: true do |t|
    t.string  "company",     limit: 5
    t.string  "glacct",      limit: 20
    t.string  "description", limit: 50
    t.string  "glgroup",     limit: 10
    t.boolean "allowje",                default: true
    t.boolean "active",                 default: false
    t.string  "ext_account", limit: 35
    t.integer "ext_id"
  end

  add_index "gl_accounts", ["company", "glacct"], name: "companyacct", unique: true, using: :btree
  add_index "gl_accounts", ["glgroup", "glacct"], name: "groupacct", using: :btree

  create_table "images", force: true do |t|
    t.binary "image",       limit: 2147483647
    t.text   "description"
    t.string "image_type",  limit: 25
  end

  add_index "images", ["image_type"], name: "image_type", using: :btree

  create_table "inv_balance_details", force: true do |t|
    t.string    "company",         limit: 5
    t.integer   "item_masters_id",                                                     null: false
    t.integer   "warehouses_id",                                                       null: false
    t.integer   "inv_balances_id",                                                     null: false
    t.integer   "bin_id",                                                              null: false
    t.decimal   "onhand",                     precision: 12, scale: 4, default: 0.0,   null: false
    t.decimal   "qa_hold_qty",                precision: 12, scale: 4
    t.decimal   "onorder",                    precision: 12, scale: 4, default: 0.0,   null: false
    t.decimal   "demand",                     precision: 12, scale: 4, default: 0.0,   null: false
    t.decimal   "allocated",                  precision: 12, scale: 4, default: 0.0,   null: false
    t.decimal   "available",                  precision: 12, scale: 4, default: 0.0,   null: false
    t.string    "uom",             limit: 5,                           default: "EA",  null: false
    t.string    "created_by",      limit: 25
    t.timestamp "created_at"
    t.string    "updated_by",      limit: 25
    t.timestamp "updated_at"
    t.boolean   "qa_hold",                                             default: false
    t.boolean   "active",                                              default: true
  end

  add_index "inv_balance_details", ["bin_id"], name: "fk_inv_balance_details_bin_idx", using: :btree
  add_index "inv_balance_details", ["company", "item_masters_id"], name: "companyitem", using: :btree
  add_index "inv_balance_details", ["company", "warehouses_id", "item_masters_id", "bin_id", "inv_balances_id", "qa_hold"], name: "itemwhsebin", unique: true, using: :btree
  add_index "inv_balance_details", ["company", "warehouses_id", "item_masters_id"], name: "itemwhhse", using: :btree
  add_index "inv_balance_details", ["inv_balances_id"], name: "fk_inv_balance_details_balance_idx", using: :btree
  add_index "inv_balance_details", ["item_masters_id"], name: "fk_inv_balance_details_item_idx", using: :btree

  create_table "inv_balances", force: true do |t|
    t.string    "company",         limit: 5
    t.integer   "item_masters_id",                                                    null: false
    t.integer   "warehouses_id",                                                      null: false
    t.decimal   "onhand",                     precision: 12, scale: 4, default: 0.0,  null: false
    t.decimal   "qa_hold_qty",                precision: 12, scale: 4, default: 0.0,  null: false
    t.decimal   "onorder",                    precision: 12, scale: 4, default: 0.0,  null: false
    t.decimal   "demand",                     precision: 12, scale: 4, default: 0.0,  null: false
    t.decimal   "allocated",                  precision: 12, scale: 4, default: 0.0,  null: false
    t.decimal   "available",                  precision: 12, scale: 4, default: 0.0,  null: false
    t.string    "uom",             limit: 5,                           default: "EA", null: false
    t.string    "created_by",      limit: 25
    t.timestamp "created_at"
    t.string    "updated_by",      limit: 25
    t.datetime  "updated_at"
  end

  add_index "inv_balances", ["company", "item_masters_id"], name: "companyitem", using: :btree
  add_index "inv_balances", ["company", "warehouses_id", "item_masters_id"], name: "itemwhhse", unique: true, using: :btree
  add_index "inv_balances", ["item_masters_id"], name: "fk_inv_balances_1_idx", using: :btree

  create_table "inv_cost_layers", force: true do |t|
    t.string    "company",         limit: 5
    t.integer   "warehouses_id",                                                      null: false
    t.integer   "item_masters_id",                                                    null: false
    t.string    "lotserial",       limit: 20
    t.decimal   "orig_qty",                   precision: 12, scale: 4, default: 0.0,  null: false
    t.decimal   "orig_cost",                  precision: 12, scale: 4, default: 0.0,  null: false
    t.decimal   "curr_qty",                   precision: 12, scale: 4, default: 0.0,  null: false
    t.decimal   "curr_cost",                  precision: 12, scale: 4, default: 0.0,  null: false
    t.string    "uom",             limit: 10,                          default: "EA", null: false
    t.boolean   "active",                                              default: true
    t.string    "created_by",      limit: 25
    t.timestamp "created_at"
    t.string    "updated_by",      limit: 25
    t.timestamp "updated_at"
    t.integer   "ext_id"
    t.string    "transcode",       limit: 3
  end

  add_index "inv_cost_layers", ["company", "item_masters_id"], name: "companyitem", using: :btree
  add_index "inv_cost_layers", ["company", "warehouses_id", "item_masters_id", "lotserial"], name: "companywhseitemlot", using: :btree
  add_index "inv_cost_layers", ["company", "warehouses_id", "item_masters_id"], name: "companywhseitem", using: :btree
  add_index "inv_cost_layers", ["item_masters_id", "company", "warehouses_id"], name: "itemwhhse", using: :btree
  add_index "inv_cost_layers", ["item_masters_id", "created_at"], name: "item", using: :btree
  add_index "inv_cost_layers", ["item_masters_id", "warehouses_id", "created_at", "active"], name: "layerdateFIFO", using: :btree
  add_index "inv_cost_layers", ["item_masters_id", "warehouses_id", "updated_by", "active"], name: "layerdateLIFO", using: :btree
  add_index "inv_cost_layers", ["item_masters_id"], name: "fk_inv_cost_layers_item_idx", using: :btree
  add_index "inv_cost_layers", ["lotserial"], name: "lotserial", using: :btree

  create_table "inv_lots", force: true do |t|
    t.string    "company",                limit: 5
    t.integer   "item_masters_id",                                                               null: false
    t.integer   "warehouses_id",                                                                 null: false
    t.integer   "inv_balances_id"
    t.integer   "inv_balance_details_id"
    t.integer   "inv_cost_layers_id"
    t.integer   "bin_id",                                                                        null: false
    t.string    "lot",                    limit: 50
    t.decimal   "orig_qty",                          precision: 12, scale: 4
    t.decimal   "good_usage",                        precision: 12, scale: 4, default: 0.0
    t.decimal   "scrap_usage",                       precision: 12, scale: 4, default: 0.0
    t.decimal   "curr_qty",                          precision: 12, scale: 4, default: 0.0,      null: false
    t.decimal   "allocated",                         precision: 12, scale: 4, default: 0.0,      null: false
    t.decimal   "available",                         precision: 12, scale: 4, default: 0.0,      null: false
    t.string    "uom",                    limit: 5,                           default: "EA",     null: false
    t.string    "created_by",             limit: 25,                          default: "MADMAX"
    t.timestamp "created_at"
    t.string    "updated_by",             limit: 25,                          default: "MADMAX"
    t.timestamp "updated_at"
    t.boolean   "qa_hold",                                                    default: false
    t.boolean   "active",                                                     default: true
  end

  add_index "inv_lots", ["company", "item_masters_id", "warehouses_id", "bin_id"], name: "itembin", using: :btree
  add_index "inv_lots", ["company", "item_masters_id", "warehouses_id", "inv_balance_details_id"], name: "itemwhsedetail", using: :btree
  add_index "inv_lots", ["company", "item_masters_id", "warehouses_id", "lot", "bin_id"], name: "itemlotbin", using: :btree
  add_index "inv_lots", ["company", "item_masters_id"], name: "companyitem", using: :btree
  add_index "inv_lots", ["company", "warehouses_id", "item_masters_id"], name: "itemwhhse", using: :btree
  add_index "inv_lots", ["inv_balance_details_id"], name: "fk_inv_lots_detail_idx", using: :btree
  add_index "inv_lots", ["inv_balances_id"], name: "fk_inv_lots_balance_idx", using: :btree
  add_index "inv_lots", ["inv_cost_layers_id"], name: "fk_inv_lots_clayer_idx", using: :btree
  add_index "inv_lots", ["item_masters_id"], name: "fk_inv_lots_item_idx", using: :btree
  add_index "inv_lots", ["lot"], name: "lot", using: :btree

  create_table "inv_serialnos", force: true do |t|
    t.string    "companies_id",           limit: 5
    t.integer   "item_masters_id",                                                            null: false
    t.integer   "wareshouses_id",                                                             null: false
    t.integer   "inv_balance_details_id"
    t.integer   "bin_id",                                                                     null: false
    t.string    "serialno",               limit: 50
    t.decimal   "onhand",                            precision: 12, scale: 4, default: 0.0,   null: false
    t.decimal   "onorder",                           precision: 12, scale: 4, default: 0.0,   null: false
    t.decimal   "demand",                            precision: 12, scale: 4, default: 0.0,   null: false
    t.decimal   "allocated",                         precision: 12, scale: 4, default: 0.0,   null: false
    t.decimal   "available",                         precision: 12, scale: 4, default: 0.0,   null: false
    t.string    "uom",                    limit: 5,                           default: "EA",  null: false
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "qa_hold",                                                    default: false
    t.boolean   "active"
    t.boolean   "is_pod"
    t.boolean   "is_panel"
    t.boolean   "is_component"
  end

  add_index "inv_serialnos", ["companies_id", "item_masters_id", "wareshouses_id", "bin_id"], name: "itembin", using: :btree
  add_index "inv_serialnos", ["companies_id", "item_masters_id", "wareshouses_id", "inv_balance_details_id"], name: "iemwhsedetail", using: :btree
  add_index "inv_serialnos", ["companies_id", "item_masters_id", "wareshouses_id", "serialno", "bin_id"], name: "itemserialbin", using: :btree
  add_index "inv_serialnos", ["companies_id", "item_masters_id"], name: "companyitem", using: :btree
  add_index "inv_serialnos", ["companies_id", "wareshouses_id", "item_masters_id"], name: "itemwhhse", using: :btree
  add_index "inv_serialnos", ["serialno"], name: "serialno", using: :btree

  create_table "item_coils", force: true do |t|
    t.string    "company",         limit: 5
    t.integer   "item_masters_id"
    t.string    "basemetal",       limit: 20
    t.decimal   "thickness",                  precision: 6, scale: 4
    t.integer   "gauge"
    t.string    "coating",         limit: 5
    t.string    "grade",           limit: 5
    t.decimal   "lbsperfoot",                 precision: 9, scale: 4
    t.decimal   "width",                      precision: 8, scale: 4
    t.string    "default_uom",     limit: 5
    t.string    "ams_material",    limit: 20
    t.boolean   "master_coil",                                        default: false
    t.string    "created_by",      limit: 25
    t.timestamp "created_at",                                                         null: false
    t.string    "updated_by",      limit: 25
    t.timestamp "updated_at",                                                         null: false
  end

  add_index "item_coils", ["company", "item_masters_id"], name: "companyitem", unique: true, using: :btree
  add_index "item_coils", ["gauge"], name: "guage", using: :btree
  add_index "item_coils", ["item_masters_id"], name: "fk_item_coil_item_idx", using: :btree

  create_table "item_company_details", force: true do |t|
    t.string    "company",          limit: 5
    t.integer   "item_masters_id"
    t.decimal   "unitweight",                  precision: 12, scale: 4
    t.string    "base_unit",        limit: 5
    t.string    "purchase_unit",    limit: 5
    t.decimal   "purchase_uom_cnv",            precision: 12, scale: 4
    t.string    "inv_unit",         limit: 5
    t.decimal   "inv_uom_cnv",                 precision: 12, scale: 4
    t.string    "sell_unit",        limit: 5
    t.decimal   "sell_uom_cnv",                precision: 12, scale: 4
    t.boolean   "taxable"
    t.string    "cost_type",        limit: 10
    t.decimal   "cost",                        precision: 12, scale: 4
    t.decimal   "last_cost",                   precision: 12, scale: 4
    t.decimal   "price",                       precision: 12, scale: 4
    t.decimal   "avg_cost",                    precision: 12, scale: 4
    t.string    "item_class",       limit: 15
    t.string    "abc_code",         limit: 1
    t.string    "item_category",    limit: 15
    t.string    "item_subcategory", limit: 15
    t.decimal   "base_cost",                   precision: 12, scale: 4
    t.decimal   "direct_cost",                 precision: 12, scale: 4
    t.decimal   "indirect_cost",               precision: 12, scale: 4
    t.decimal   "standard_cost",               precision: 12, scale: 4
    t.boolean   "lot_control",                                          default: false
    t.boolean   "serialized",                                           default: false
    t.boolean   "produce",                                              default: false
    t.boolean   "bom_item",                                             default: false
    t.boolean   "consumable",                                           default: false
    t.boolean   "qa_inspect",                                           default: false
    t.boolean   "active",                                               default: false
    t.boolean   "inventory_item",                                       default: false
    t.boolean   "retainage_item",                                       default: false
    t.boolean   "coil_item"
    t.boolean   "framing_item"
    t.string    "created_by",       limit: 25
    t.timestamp "created_at",                                                           null: false
    t.string    "updated_by",       limit: 25
    t.timestamp "updated_at",                                                           null: false
    t.integer   "ext_id"
  end

  add_index "item_company_details", ["company", "item_masters_id"], name: "companyitem", unique: true, using: :btree
  add_index "item_company_details", ["item_category"], name: "category", using: :btree
  add_index "item_company_details", ["item_class"], name: "class", using: :btree
  add_index "item_company_details", ["item_masters_id"], name: "item", using: :btree

  create_table "item_framings", force: true do |t|
    t.string    "company",         limit: 5
    t.integer   "item_masters_id"
    t.integer   "gauge"
    t.string    "coating",         limit: 5
    t.string    "grade",           limit: 5
    t.decimal   "lbsperfoot",                 precision: 9, scale: 4
    t.decimal   "web",                        precision: 8, scale: 4
    t.decimal   "leg_flange",                 precision: 8, scale: 4
    t.decimal   "return_dim",                 precision: 8, scale: 4
    t.string    "default_uom",     limit: 5
    t.string    "ams_pcode",       limit: 20
    t.string    "ams_material",    limit: 20
    t.boolean   "stud",                                               default: false
    t.boolean   "track",                                              default: false
    t.boolean   "accessorial",                                        default: false
    t.string    "created_by",      limit: 25
    t.timestamp "created_at",                                                         null: false
    t.string    "updated_by",      limit: 25
    t.timestamp "updated_at",                                                         null: false
  end

  add_index "item_framings", ["ams_material"], name: "amsmaterial", using: :btree
  add_index "item_framings", ["company", "item_masters_id"], name: "companyitem", unique: true, using: :btree
  add_index "item_framings", ["gauge"], name: "gauge", using: :btree
  add_index "item_framings", ["item_masters_id"], name: "fk_item_framing_item_idx", using: :btree

  create_table "item_ledgers", force: true do |t|
    t.string    "company",            limit: 5
    t.integer   "item_masters_id",                                                       null: false
    t.integer   "warehouses_id",                                                         null: false
    t.integer   "bin_id"
    t.string    "transcode",          limit: 3
    t.string    "document_num",       limit: 30
    t.integer   "document_header_id"
    t.string    "document_type",      limit: 30
    t.integer   "document_detail_id"
    t.integer   "import_line_id"
    t.string    "lotserial",          limit: 50
    t.decimal   "openbal",                       precision: 12, scale: 4, default: 0.0,  null: false
    t.decimal   "quantity",                      precision: 12, scale: 4, default: 0.0,  null: false
    t.decimal   "cost",                          precision: 12, scale: 4, default: 0.0,  null: false
    t.string    "uom",                limit: 5,                           default: "EA", null: false
    t.decimal   "closebal",                      precision: 12, scale: 4, default: 0.0
    t.integer   "inv_cost_layers_id"
    t.string    "created_by",         limit: 25
    t.timestamp "created_at"
    t.string    "updated_by",         limit: 25
    t.timestamp "updated_at"
    t.boolean   "qa_hold"
  end

  add_index "item_ledgers", ["bin_id"], name: "fk_item_ledgers_bin_idx", using: :btree
  add_index "item_ledgers", ["company", "item_masters_id", "warehouses_id"], name: "itemcostlayer", using: :btree
  add_index "item_ledgers", ["company", "item_masters_id"], name: "companyitem", using: :btree
  add_index "item_ledgers", ["company", "warehouses_id", "item_masters_id"], name: "itemwhhse", using: :btree
  add_index "item_ledgers", ["created_at"], name: "createddate", using: :btree
  add_index "item_ledgers", ["inv_cost_layers_id"], name: "fk_item_ledgers_clayer_idx", using: :btree
  add_index "item_ledgers", ["item_masters_id"], name: "fk_item_ledgers_item_idx", using: :btree
  add_index "item_ledgers", ["lotserial"], name: "fk_item_ledgers_lot_idx", using: :btree

  create_table "item_masters", force: true do |t|
    t.string    "valid_companies"
    t.string    "item_number",      limit: 30
    t.string    "description",      limit: 100
    t.decimal   "unitweight",                   precision: 12, scale: 4
    t.string    "base_unit",        limit: 5
    t.string    "purchase_unit",    limit: 5
    t.decimal   "purchase_uom_cnv",             precision: 12, scale: 4
    t.string    "inv_unit",         limit: 5
    t.decimal   "inv_uom_cnv",                  precision: 12, scale: 4
    t.string    "sell_unit",        limit: 5
    t.decimal   "sell_uom_cnv",                 precision: 12, scale: 4
    t.boolean   "taxable",                                               default: true
    t.string    "cost_type",        limit: 10
    t.decimal   "cost",                         precision: 12, scale: 4
    t.decimal   "last_cost",                    precision: 12, scale: 4
    t.decimal   "price",                        precision: 12, scale: 4
    t.decimal   "avg_cost",                     precision: 12, scale: 4
    t.string    "item_class",       limit: 15
    t.string    "item_category",    limit: 15
    t.string    "item_subcategory", limit: 15
    t.string    "abc_code",         limit: 1
    t.decimal   "base_cost",                    precision: 12, scale: 4
    t.decimal   "direct_cost",                  precision: 12, scale: 4
    t.decimal   "indirect_cost",                precision: 12, scale: 4
    t.decimal   "standard_cost",                precision: 12, scale: 4
    t.boolean   "lot_control",                                           default: false
    t.boolean   "serialized",                                            default: false
    t.boolean   "produce",                                               default: false
    t.boolean   "bom_item",                                              default: false
    t.boolean   "consumable",                                            default: false
    t.boolean   "qa_inspect",                                            default: false
    t.boolean   "active",                                                default: false
    t.boolean   "inventory_item",                                        default: false
    t.boolean   "retainage_item",                                        default: false
    t.boolean   "coil_item",                                             default: false
    t.boolean   "framing_item",                                          default: false
    t.string    "created_by",       limit: 25
    t.timestamp "created_at",                                                            null: false
    t.string    "updated_by",       limit: 25
    t.timestamp "updated_at",                                                            null: false
    t.integer   "ext_id"
  end

  add_index "item_masters", ["ext_id"], name: "extid", unique: true, using: :btree
  add_index "item_masters", ["item_category"], name: "category", using: :btree
  add_index "item_masters", ["item_class"], name: "class", using: :btree
  add_index "item_masters", ["item_number"], name: "item", unique: true, using: :btree

  create_table "modules", force: true do |t|
    t.string    "module",      limit: 3
    t.string    "description", limit: 50
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "modules", ["module"], name: "module", unique: true, using: :btree

  create_table "phase_masters", force: true do |t|
    t.integer   "project_masters_id"
    t.string    "description",               limit: 25
    t.string    "status",                    limit: 25
    t.date      "estimated_production_date"
    t.date      "scheduled_production_date"
    t.date      "actual_production_date"
    t.date      "last_revision_date"
    t.integer   "revision_count"
    t.integer   "phase_type_id"
    t.string    "phase_type",                limit: 25
    t.string    "project_manager",           limit: 25
    t.string    "cad_designer",              limit: 25
    t.string    "created_by",                limit: 25
    t.timestamp "created_at",                           null: false
    t.string    "updated_by",                limit: 25
    t.timestamp "updated_at",                           null: false
    t.integer   "hsb_project_item_id"
    t.integer   "hsb_phase_id"
    t.integer   "ext_phase_id"
  end

  add_index "phase_masters", ["project_masters_id", "description"], name: "projectphase", unique: true, using: :btree
  add_index "phase_masters", ["project_masters_id"], name: "project_id", using: :btree

  create_table "prod_lines", force: true do |t|
    t.string   "company"
    t.string   "prod_line_desc"
    t.string   "prod_line_prefix"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "production_summaries", force: true do |t|
    t.integer  "companies_id"
    t.date     "proddate"
    t.string   "trans_code"
    t.string   "workstation"
    t.decimal  "units",        precision: 10, scale: 0
    t.decimal  "unitcount",    precision: 10, scale: 0
    t.string   "uom"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "production_summaries", ["companies_id", "trans_code", "created_at"], name: "company_trans_code_date", using: :btree
  add_index "production_summaries", ["companies_id", "trans_code"], name: "company_trans_code", using: :btree
  add_index "production_summaries", ["companies_id", "workstation"], name: "company_workstation", using: :btree
  add_index "production_summaries", ["trans_code"], name: "trans_code", using: :btree

  create_table "project_estimates", force: true do |t|
    t.string   "projectStatus",   limit: 10,                          default: "active"
    t.string   "projectNum"
    t.string   "projectName"
    t.string   "projectLocation"
    t.decimal  "estBOMM",                    precision: 12, scale: 4, default: 0.0
    t.decimal  "poBOMM",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "porecBOMM",                  precision: 12, scale: 4, default: 0.0
    t.decimal  "apBOMM",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "pdBOMM",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "poBOSS",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "estBOSS",                    precision: 12, scale: 4, default: 0.0
    t.decimal  "porecBOSS",                  precision: 12, scale: 4, default: 0.0
    t.decimal  "apBOSS",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "pdBOSS",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "poBOFS",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "estBOFS",                    precision: 12, scale: 4, default: 0.0
    t.decimal  "porecBOFS",                  precision: 12, scale: 4, default: 0.0
    t.decimal  "apBOFS",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "pdBOFS",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "poBORS",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "estBORS",                    precision: 12, scale: 4, default: 0.0
    t.decimal  "porecBORS",                  precision: 12, scale: 4, default: 0.0
    t.decimal  "apBORS",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "pdBORS",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "estBONR",                    precision: 12, scale: 4, default: 0.0
    t.decimal  "poBONR",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "porecBONR",                  precision: 12, scale: 4, default: 0.0
    t.decimal  "apBONR",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "pdBONR",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "estBONF",                    precision: 12, scale: 4, default: 0.0
    t.decimal  "poBONF",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "porecBONF",                  precision: 12, scale: 4, default: 0.0
    t.decimal  "apBONF",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "pdBONF",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "poLoads",                    precision: 12, scale: 4, default: 0.0
    t.decimal  "estLoads",                   precision: 12, scale: 4, default: 0.0
    t.decimal  "poSHIP",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "estSHIP",                    precision: 12, scale: 4, default: 0.0
    t.decimal  "porecSHIP",                  precision: 12, scale: 4, default: 0.0
    t.decimal  "apSHIP",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "pdSHIP",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "poDUNN",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "estDUNN",                    precision: 12, scale: 4, default: 0.0
    t.decimal  "porecDUNN",                  precision: 12, scale: 4, default: 0.0
    t.decimal  "apDUNN",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "pdDUNN",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "poENG",                      precision: 12, scale: 4, default: 0.0
    t.decimal  "estENG",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "porecENG",                   precision: 12, scale: 4, default: 0.0
    t.decimal  "pdENG",                      precision: 12, scale: 4, default: 0.0
    t.decimal  "apENG",                      precision: 12, scale: 4, default: 0.0
    t.decimal  "poINWP",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "estINWP",                    precision: 12, scale: 4, default: 0.0
    t.decimal  "porecINWP",                  precision: 12, scale: 4, default: 0.0
    t.decimal  "pdINWP",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "apINWP",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "poINSS",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "estINSS",                    precision: 12, scale: 4, default: 0.0
    t.decimal  "porecINSS",                  precision: 12, scale: 4, default: 0.0
    t.decimal  "pdINSS",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "apINSS",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "poINFL",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "estINFL",                    precision: 12, scale: 4, default: 0.0
    t.decimal  "porecINFL",                  precision: 12, scale: 4, default: 0.0
    t.decimal  "apINFL",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "pdINFL",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "poINRL",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "estINRL",                    precision: 12, scale: 4, default: 0.0
    t.decimal  "porecINRL",                  precision: 12, scale: 4, default: 0.0
    t.decimal  "apINRL",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "pdINRL",                     precision: 12, scale: 4, default: 0.0
    t.decimal  "estValue",                   precision: 12, scale: 4, default: 0.0
    t.decimal  "ordValue",                   precision: 12, scale: 4, default: 0.0
    t.decimal  "shpValue",                   precision: 12, scale: 4
    t.decimal  "actStWght",                  precision: 12, scale: 4, default: 0.0
    t.decimal  "estStWght",                  precision: 12, scale: 4, default: 0.0
    t.decimal  "estBldgArea",                precision: 12, scale: 4, default: 0.0
    t.decimal  "estLinearFeet",              precision: 12, scale: 4
    t.decimal  "estProdDays",                precision: 12, scale: 4, default: 0.0
    t.decimal  "actProdDays",                precision: 12, scale: 4, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_estimates", ["projectNum"], name: "projectNum", unique: true, using: :btree

  create_table "project_masters", force: true do |t|
    t.string    "project",                   limit: 10
    t.string    "description",               limit: 50
    t.string    "status",                    limit: 25
    t.date      "estimated_production_date"
    t.date      "scheduled_production_date"
    t.date      "actual_production_date"
    t.date      "last_revision_date"
    t.integer   "revision_count"
    t.integer   "project_type_id"
    t.string    "project_type",              limit: 25
    t.string    "project_manager",           limit: 25
    t.string    "cad_designer",              limit: 25
    t.string    "created_by",                limit: 25
    t.timestamp "created_at",                           null: false
    t.string    "updated_by",                limit: 25
    t.timestamp "updated_at",                           null: false
    t.integer   "hsb_project_id"
    t.integer   "ext_project_id"
  end

  add_index "project_masters", ["project"], name: "project", unique: true, using: :btree

  create_table "project_types", force: true do |t|
    t.string    "project_type", limit: 25
    t.integer   "created_by"
    t.timestamp "created_at"
    t.integer   "updated_by"
    t.timestamp "updated_at"
  end

  add_index "project_types", ["project_type"], name: "project_type", unique: true, using: :btree

  create_table "pwo_headers", force: true do |t|
    t.string   "company",               limit: 5
    t.integer  "warehouses_id"
    t.integer  "workstations_id"
    t.string   "pwo_worderno",          limit: 50
    t.integer  "parent_pwo_headers_id"
    t.integer  "project_masters_id"
    t.integer  "phase_masters_id"
    t.integer  "sales_orders_id"
    t.string   "sales_order_number",    limit: 30
    t.integer  "pwo_status"
    t.date     "date_released"
    t.date     "date_scheduled"
    t.date     "date_started"
    t.date     "date_complete"
    t.text     "notes"
    t.text     "user_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pwo_headers", ["company", "warehouses_id"], name: "export_key", using: :btree
  add_index "pwo_headers", ["pwo_worderno", "company", "warehouses_id"], name: "worder", using: :btree
  add_index "pwo_headers", ["sales_orders_id", "company", "warehouses_id"], name: "sales_order", using: :btree

  create_table "pwo_line_details", force: true do |t|
    t.string    "company",         limit: 5
    t.integer   "warehouses_id"
    t.integer   "workstations_id"
    t.integer   "pwo_headers_id"
    t.integer   "pwo_lines_id"
    t.integer   "item_masters_id"
    t.string    "item_number",     limit: 30
    t.decimal   "req_qty",                    precision: 12, scale: 4, default: 0.0
    t.decimal   "good_qty_used",              precision: 12, scale: 4, default: 0.0
    t.decimal   "scrap_qty_used",             precision: 12, scale: 4, default: 0.0
    t.decimal   "total_qty_used",             precision: 12, scale: 4, default: 0.0
    t.string    "lotserial",       limit: 50
    t.text      "line_notes"
    t.text      "user_notes"
    t.string    "created_by",      limit: 25
    t.timestamp "created_at",                                                        null: false
    t.string    "updated_by",      limit: 25
    t.timestamp "updated_at",                                                        null: false
    t.integer   "status"
    t.string    "uom",             limit: 5
  end

  add_index "pwo_line_details", ["item_masters_id", "pwo_lines_id", "company", "warehouses_id", "lotserial"], name: "pwolinelot", unique: true, using: :btree
  add_index "pwo_line_details", ["item_masters_id"], name: "itemid", using: :btree
  add_index "pwo_line_details", ["pwo_headers_id"], name: "pwoheaderid", using: :btree
  add_index "pwo_line_details", ["pwo_lines_id"], name: "pwolinesid", using: :btree
  add_index "pwo_line_details", ["workstations_id"], name: "workstationid", using: :btree

  create_table "pwo_lines", force: true do |t|
    t.string   "company",             limit: 30
    t.integer  "warehouses_id"
    t.integer  "pwo_headers_id"
    t.integer  "parent_pwo_lines_id"
    t.integer  "item_masters_id"
    t.integer  "sales_orders_id"
    t.integer  "order_lines_id"
    t.integer  "users_id"
    t.decimal  "req_qty",                        precision: 12, scale: 4, default: 0.0
    t.decimal  "actual_qty",                     precision: 12, scale: 4, default: 0.0
    t.boolean  "is_lot",                                                  default: false
    t.boolean  "is_serial",                                               default: false
    t.text     "notes"
    t.text     "user_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pwo_line_status"
    t.string   "item_number",         limit: 30
    t.decimal  "length",                         precision: 12, scale: 4
    t.string   "piecemark",           limit: 25
  end

  add_index "pwo_lines", ["item_masters_id", "pwo_line_status"], name: "item_status", using: :btree
  add_index "pwo_lines", ["item_masters_id"], name: "itemid", using: :btree
  add_index "pwo_lines", ["order_lines_id"], name: "orderlineid", using: :btree
  add_index "pwo_lines", ["parent_pwo_lines_id"], name: "parent_pwo_line", using: :btree
  add_index "pwo_lines", ["pwo_headers_id"], name: "pwo_header", using: :btree

  create_table "rollformer_qa_checks", force: true do |t|
    t.string   "company",                limit: 5
    t.integer  "warehouses_id"
    t.integer  "pwo_headers_id"
    t.integer  "pwo_lines_id"
    t.integer  "item_masters_id"
    t.string   "item_number",            limit: 30
    t.integer  "workstations_id"
    t.string   "coilid",                 limit: 50
    t.string   "coil_material",          limit: 50
    t.integer  "users_id"
    t.integer  "piececount"
    t.string   "piecemark"
    t.decimal  "thickness",                         precision: 5,  scale: 4
    t.decimal  "required_length",                   precision: 12, scale: 4
    t.decimal  "actual_length",                     precision: 12, scale: 4
    t.decimal  "hole_center_width_A",               precision: 12, scale: 4
    t.decimal  "hole_center_width_B",               precision: 12, scale: 4
    t.decimal  "flange_C",                          precision: 12, scale: 4
    t.decimal  "web_D",                             precision: 12, scale: 4
    t.decimal  "flange_E",                          precision: 12, scale: 4
    t.decimal  "return_F",                          precision: 12, scale: 4
    t.decimal  "flare",                             precision: 12, scale: 4
    t.decimal  "overbend",                          precision: 12, scale: 4
    t.decimal  "crown",                             precision: 12, scale: 4
    t.decimal  "camber",                            precision: 12, scale: 4
    t.decimal  "bow",                               precision: 12, scale: 4
    t.decimal  "twist",                             precision: 12, scale: 4
    t.boolean  "meets_visual",                                               default: false
    t.boolean  "in_spec",                                                    default: true
    t.boolean  "needs_manager_approval",                                     default: false
    t.text     "user_notes"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rollformer_qa_checks", ["coil_material"], name: "coil_material", using: :btree
  add_index "rollformer_qa_checks", ["coilid"], name: "coil", using: :btree
  add_index "rollformer_qa_checks", ["pwo_headers_id", "item_masters_id"], name: "workorder_item", using: :btree
  add_index "rollformer_qa_checks", ["pwo_headers_id"], name: "workorder", using: :btree

  create_table "security_groups", force: true do |t|
    t.string   "validcompanies"
    t.string   "security_group_desc"
    t.decimal  "security_level",      precision: 10, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "security_groups", ["security_group_desc"], name: "sec_group", using: :btree

  create_table "statuses", force: true do |t|
    t.string    "status"
    t.string    "description"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "trans_codes", force: true do |t|
    t.string    "transcode",   limit: 3
    t.string    "description", limit: 50
    t.string    "module",      limit: 2
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "trans_codes", ["transcode", "module"], name: "transmodule", unique: true, using: :btree
  add_index "trans_codes", ["transcode"], name: "transcode", unique: true, using: :btree

  create_table "truss_trackings", force: true do |t|
    t.integer  "trusses_id"
    t.string   "trans_code"
    t.integer  "users_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "trusslabel"
  end

  add_index "truss_trackings", ["trusses_id", "created_at"], name: "created", using: :btree
  add_index "truss_trackings", ["trusses_id", "trans_code", "created_at"], name: "transcode", using: :btree
  add_index "truss_trackings", ["trusses_id"], name: "trusses_id", using: :btree

  create_table "trusses", force: true do |t|
    t.string    "project",            limit: 20
    t.integer   "project_id"
    t.string    "phase",              limit: 20
    t.integer   "phase_id"
    t.integer   "item_masters_id"
    t.string    "trussid",            limit: 10
    t.integer   "trussid_quantity"
    t.string    "trusslabel",         limit: 30
    t.integer   "gauge"
    t.string    "ply",                limit: 10
    t.decimal   "length",                        precision: 12, scale: 4
    t.decimal   "footage",                       precision: 12, scale: 4
    t.decimal   "weight",                        precision: 12, scale: 4
    t.integer   "bolts"
    t.integer   "screws"
    t.integer   "spacers"
    t.string    "xofy",               limit: 15
    t.integer   "prod_sequence"
    t.string    "bundle_position",    limit: 5
    t.string    "bundle_id",          limit: 50
    t.string    "bundle_description", limit: 20
    t.integer   "bundle_sequence"
    t.string    "created_by",         limit: 25
    t.timestamp "created_at",                                                              null: false
    t.string    "updated_by",         limit: 25
    t.timestamp "updated_at",                                                              null: false
    t.boolean   "is_active",                                              default: true
    t.integer   "coil_id"
    t.string    "coil_material",      limit: 50
    t.string    "status",             limit: 25,                          default: "open"
    t.boolean   "production_sent",                                        default: false
  end

  add_index "trusses", ["project", "phase"], name: "projectphase", using: :btree
  add_index "trusses", ["project"], name: "project", using: :btree
  add_index "trusses", ["trussid"], name: "trussid", using: :btree
  add_index "trusses", ["trusslabel"], name: "trusslabel", unique: true, using: :btree

  create_table "user_securities", force: true do |t|
    t.string   "company"
    t.integer  "userid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "module"
    t.string   "sub_module"
    t.string   "access_page"
    t.boolean  "can_add",     default: false
    t.boolean  "can_edit",    default: false
    t.boolean  "can_delete",  default: false
  end

  create_table "users", force: true do |t|
    t.string   "validcompanies"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "workstation"
    t.string   "jobtitle"
    t.string   "username"
    t.string   "password_digest"
    t.string   "email"
    t.string   "email2"
    t.string   "im_address"
    t.string   "phone",               limit: 10, default: "5192721001"
    t.integer  "phone_country_code"
    t.integer  "extension"
    t.integer  "mobile"
    t.integer  "mobile_country_code"
    t.integer  "substituteid"
    t.boolean  "is_local",                       default: true
    t.boolean  "is_active",                      default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "email", using: :btree
  add_index "users", ["firstname", "lastname"], name: "firstlast", using: :btree
  add_index "users", ["phone"], name: "phone", using: :btree
  add_index "users", ["username"], name: "username", using: :btree

  create_table "wallpanel_trackings", force: true do |t|
    t.integer  "wallpanels_id"
    t.string   "trans_code"
    t.integer  "users_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "panellabel"
  end

  add_index "wallpanel_trackings", ["wallpanels_id", "created_at"], name: "created", using: :btree
  add_index "wallpanel_trackings", ["wallpanels_id", "trans_code", "created_at"], name: "transcode", using: :btree
  add_index "wallpanel_trackings", ["wallpanels_id"], name: "wallpanel_id", using: :btree

  create_table "wallpanels", force: true do |t|
    t.string   "panelnumber"
    t.string   "panellabel"
    t.string   "exportkey"
    t.string   "projectnumber"
    t.string   "exposure"
    t.decimal  "length",          precision: 10, scale: 4
    t.decimal  "height",          precision: 10, scale: 4
    t.decimal  "areagross",       precision: 10, scale: 4
    t.decimal  "areanet",         precision: 10, scale: 4
    t.boolean  "is_loadbearing"
    t.boolean  "is_sheathed"
    t.decimal  "weight",          precision: 10, scale: 4
    t.decimal  "weight_sheathed", precision: 10, scale: 4
    t.integer  "prod_sequence"
    t.string   "bundle_id"
    t.string   "bundle_position"
    t.integer  "bundle_sequence"
    t.string   "updated_by"
    t.boolean  "is_active",                                default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  add_index "wallpanels", ["bundle_id"], name: "bundle", using: :btree
  add_index "wallpanels", ["exportkey", "bundle_id"], name: "exportkey_bundle", using: :btree
  add_index "wallpanels", ["exportkey"], name: "exportkey", using: :btree
  add_index "wallpanels", ["panellabel"], name: "panellabel", unique: true, using: :btree
  add_index "wallpanels", ["panelnumber", "bundle_id"], name: "panel_bundle", using: :btree
  add_index "wallpanels", ["projectnumber"], name: "project", using: :btree

  create_table "warehouses", force: true do |t|
    t.string  "valid_companies",         limit: 30
    t.string  "warehouse_name",          limit: 50
    t.string  "short_name",              limit: 10
    t.string  "street_address1",         limit: 50
    t.string  "street_address2",         limit: 50
    t.string  "street_address3",         limit: 50
    t.string  "street_city",             limit: 50
    t.string  "street_prov",             limit: 50
    t.string  "street_pcode",            limit: 20
    t.string  "street_country",          limit: 50
    t.string  "mail_address1",           limit: 50
    t.string  "mail_address2",           limit: 50
    t.string  "mail_address3",           limit: 50
    t.string  "mail_city",               limit: 50
    t.string  "mail_prov",               limit: 50
    t.string  "mail_pcode",              limit: 20
    t.string  "mail_country",            limit: 50
    t.string  "phone",                   limit: 20
    t.string  "fax",                     limit: 20
    t.string  "email",                   limit: 50
    t.string  "local_currency",          limit: 3
    t.string  "inv_stock_acct",          limit: 15
    t.string  "inv_nonstock_acct",       limit: 15
    t.string  "control_acct",            limit: 15
    t.string  "po_accural_acct",         limit: 15
    t.string  "inventory_clearing_acct", limit: 15
    t.string  "wip_acct",                limit: 15
    t.boolean "active",                             default: true
    t.string  "edi_code",                limit: 10
    t.boolean "is_consignment",                     default: false
  end

  add_index "warehouses", ["short_name"], name: "whse", using: :btree

  create_table "whse_zones", force: true do |t|
    t.string  "company",        limit: 5
    t.integer "warehouses_id"
    t.string  "zone",           limit: 25
    t.boolean "is_secure_pick",            default: false
    t.boolean "active",                    default: true
    t.integer "ext_id"
    t.boolean "qa_hold",                   default: false
  end

  add_index "whse_zones", ["company", "warehouses_id", "zone", "is_secure_pick"], name: "issecure", using: :btree
  add_index "whse_zones", ["company", "warehouses_id", "zone"], name: "companywhsezone", using: :btree
  add_index "whse_zones", ["zone"], name: "zone", using: :btree

  create_table "workstations", force: true do |t|
    t.string   "company"
    t.string   "workstation"
    t.integer  "prod_lineid"
    t.decimal  "prod_sequence",             precision: 10, scale: 0
    t.decimal  "min_security",              precision: 10, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "machine_number", limit: 10
  end

  add_index "workstations", ["workstation", "prod_sequence"], name: "workstation_sequence", using: :btree
  add_index "workstations", ["workstation"], name: "workstation", using: :btree

end
