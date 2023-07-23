# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_21_021840) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "btree_gist"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "amazon_cost_of_goods", force: :cascade do |t|
    t.uuid "amazon_cost_of_good_id", default: -> { "uuid_generate_v4()" }, null: false
    t.uuid "user_id", null: false
    t.bigint "amazon_marketplace_id"
    t.string "sku", null: false
    t.decimal "amount", precision: 10, scale: 2
    t.integer "date_time", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["amazon_marketplace_id"], name: "idx_amazon_cost_of_goods_amazon_marketplace_id"
    t.index ["user_id", "amazon_marketplace_id", "sku", "date_time"], name: "amazon_cost_of_goods_unique", unique: true
  end

  create_table "amazon_custom_transactions", force: :cascade do |t|
    t.uuid "user_id", null: false
    t.datetime "date_time", null: false
    t.bigint "settlement_id", null: false
    t.bigint "amazon_transaction_type_id"
    t.string "order_id", null: false
    t.string "sku", null: false
    t.string "description", null: false
    t.integer "quantity", null: false
    t.bigint "amazon_marketplace_id"
    t.bigint "amazon_fulfillment_id"
    t.bigint "amazon_tax_collection_model_id"
    t.decimal "product_sales", precision: 10, scale: 2
    t.decimal "product_sales_tax", precision: 10, scale: 2
    t.decimal "shipping_credits", precision: 10, scale: 2
    t.decimal "shipping_credits_tax", precision: 10, scale: 2
    t.decimal "giftwrap_credits", precision: 10, scale: 2
    t.decimal "giftwrap_credits_tax", precision: 10, scale: 2
    t.decimal "promotional_rebates", precision: 10, scale: 2
    t.decimal "promotional_rebates_tax", precision: 10, scale: 2
    t.decimal "marketplace_withheld_tax", precision: 10, scale: 2
    t.decimal "selling_fees", precision: 10, scale: 2
    t.decimal "fba_fees", precision: 10, scale: 2
    t.decimal "other_transaction_fees", precision: 10, scale: 2
    t.decimal "other", precision: 10, scale: 2
    t.decimal "total", precision: 10, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["amazon_fulfillment_id"], name: "idx_amazon_custom_transactions_amazon_fulfillment_id"
    t.index ["amazon_marketplace_id"], name: "idx_amazon_custom_transactions_amazon_marketplace_id"
    t.index ["amazon_tax_collection_model_id"], name: "idx_amazon_custom_transactions_amazon_tax_collection_model_id"
    t.index ["amazon_transaction_type_id"], name: "idx_amazon_custom_transactions_amazon_transaction_type_id"
    t.index ["user_id", "date_time", "settlement_id", "amazon_transaction_type_id", "order_id", "sku", "total"], name: "index_amazon_custom_transactions_unique", unique: true
  end

  create_table "amazon_fulfillments", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_amazon_fulfillments_on_name", unique: true
  end

  create_table "amazon_marketplaces", force: :cascade do |t|
    t.uuid "amazon_marketplace_id", default: -> { "uuid_generate_v4()" }, null: false
    t.string "name", null: false
    t.bigint "currency_exchange_rate_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["currency_exchange_rate_id"], name: "idx_amazon_marketplaces_currency_exchange_rate_id"
    t.index ["name"], name: "index_amazon_marketplaces_on_name", unique: true
  end

  create_table "amazon_sponsored_products", force: :cascade do |t|
    t.uuid "user_id", null: false
    t.datetime "date_time", null: false
    t.string "portfolio_name", null: false
    t.bigint "currency_exchange_rate_id"
    t.string "campaign_name", null: false
    t.string "ad_group_name", null: false
    t.string "sku", null: false
    t.string "asin", null: false
    t.integer "impressions"
    t.integer "clicks"
    t.decimal "ctr", precision: 10, scale: 2
    t.decimal "cpc", precision: 10, scale: 2
    t.decimal "spend", precision: 10, scale: 2
    t.decimal "total_sales", precision: 10, scale: 2
    t.decimal "acos", precision: 10, scale: 2
    t.decimal "roas", precision: 10, scale: 2
    t.integer "total_orders"
    t.integer "total_units"
    t.decimal "conversion_rate", precision: 10, scale: 2
    t.integer "advertised_sku_units"
    t.integer "other_sku_units"
    t.decimal "advertised_sku_sales", precision: 10, scale: 2
    t.decimal "other_sku_sales", precision: 10, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["currency_exchange_rate_id"], name: "idx_amazon_sponsored_products_currency_exchange_rate_id"
    t.index ["user_id", "date_time", "portfolio_name", "campaign_name", "ad_group_name", "sku", "asin"], name: "amazon_sponsored_products_unique", unique: true
  end

  create_table "amazon_tax_collection_models", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_amazon_tax_collection_models_on_name", unique: true
  end

  create_table "amazon_transaction_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_amazon_transaction_types_on_name", unique: true
  end

  create_table "currency_exchange_rates", force: :cascade do |t|
    t.uuid "currency_exchange_rate_id", default: -> { "uuid_generate_v4()" }, null: false
    t.string "code", null: false
    t.decimal "exchange_rate", precision: 10, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_currency_exchange_rates_on_code", unique: true
  end

  create_table "expenses_others", force: :cascade do |t|
    t.uuid "expenses_other_id", default: -> { "uuid_generate_v4()" }, null: false
    t.uuid "user_id", null: false
    t.bigint "currency_exchange_rate_id"
    t.decimal "amount", precision: 10, scale: 2
    t.integer "date_time", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["currency_exchange_rate_id"], name: "idx_expenses_others_currency_exchange_rate_id"
  end

  add_foreign_key "amazon_cost_of_goods", "amazon_marketplaces"
  add_foreign_key "amazon_custom_transactions", "amazon_fulfillments"
  add_foreign_key "amazon_custom_transactions", "amazon_marketplaces"
  add_foreign_key "amazon_custom_transactions", "amazon_tax_collection_models"
  add_foreign_key "amazon_custom_transactions", "amazon_transaction_types"
  add_foreign_key "amazon_marketplaces", "currency_exchange_rates"
  add_foreign_key "amazon_sponsored_products", "currency_exchange_rates"
  add_foreign_key "expenses_others", "currency_exchange_rates"
end
