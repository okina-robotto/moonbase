class CreateAmazonSponsoredProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :amazon_sponsored_products do |t|
      t.uuid :user_id, null: false
      t.timestamp :date_time, null: false
      t.string :portfolio_name, null: false
      t.references :currency_exchange_rate, foreign_key: true, index: { name: :idx_amazon_sponsored_products_currency_exchange_rate_id }
      t.string :campaign_name, null: false
      t.string :ad_group_name, null: false
      t.string :sku, null: false
      t.string :asin, null: false
      t.integer :impressions
      t.integer :clicks
      t.decimal :ctr, precision: 10, scale: 2
      t.decimal :cpc, precision: 10, scale: 2
      t.decimal :spend, precision: 10, scale: 2
      t.decimal :total_sales, precision: 10, scale: 2
      t.decimal :acos, precision: 10, scale: 2
      t.decimal :roas, precision: 10, scale: 2
      t.integer :total_orders
      t.integer :total_units
      t.decimal :conversion_rate, precision: 10, scale: 2
      t.integer :advertised_sku_units
      t.integer :other_sku_units
      t.decimal :advertised_sku_sales, precision: 10, scale: 2
      t.decimal :other_sku_sales, precision: 10, scale: 2
      t.timestamps
    end

    add_index :amazon_sponsored_products, %i[user_id date_time portfolio_name campaign_name ad_group_name sku asin], name: :amazon_sponsored_products_unique, unique: true
  end
end
