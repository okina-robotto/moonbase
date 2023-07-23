class CreateAmazonMarketplaces < ActiveRecord::Migration[6.0]
  def change
    create_table :amazon_marketplaces do |t|
      t.uuid :amazon_marketplace_id, null: false, default: "uuid_generate_v4()"
      t.string :name, null: false, index: { unique: true }
      t.references :currency_exchange_rate, foreign_key: true, index: { name: :idx_amazon_marketplaces_currency_exchange_rate_id }
      t.timestamps
    end
  end
end
