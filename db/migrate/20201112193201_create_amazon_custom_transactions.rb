class CreateAmazonCustomTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :amazon_custom_transactions do |t|
      t.uuid :user_id, null: false
      t.timestamp :date_time, null: false
      t.bigint :settlement_id, null: false
      t.references :amazon_transaction_type, foreign_key: true, index: { name: :idx_amazon_custom_transactions_amazon_transaction_type_id }
      t.string :order_id, null: false
      t.string :sku, null: false
      t.string :description, null: false
      t.integer :quantity, null: false
      t.references :amazon_marketplace, foreign_key: true, index: { name: :idx_amazon_custom_transactions_amazon_marketplace_id }
      t.references :amazon_fulfillment, foreign_key: true, index: { name: :idx_amazon_custom_transactions_amazon_fulfillment_id }
      t.references :amazon_tax_collection_model, foreign_key: true, index: { name: :idx_amazon_custom_transactions_amazon_tax_collection_model_id }
      t.decimal :product_sales, precision: 10, scale: 2
      t.decimal :product_sales_tax, precision: 10, scale: 2
      t.decimal :shipping_credits, precision: 10, scale: 2
      t.decimal :shipping_credits_tax, precision: 10, scale: 2
      t.decimal :giftwrap_credits, precision: 10, scale: 2
      t.decimal :giftwrap_credits_tax, precision: 10, scale: 2
      t.decimal :promotional_rebates, precision: 10, scale: 2
      t.decimal :promotional_rebates_tax, precision: 10, scale: 2
      t.decimal :marketplace_withheld_tax, precision: 10, scale: 2
      t.decimal :selling_fees, precision: 10, scale: 2
      t.decimal :fba_fees, precision: 10, scale: 2
      t.decimal :other_transaction_fees, precision: 10, scale: 2
      t.decimal :other, precision: 10, scale: 2
      t.decimal :total, precision: 10, scale: 2
      t.timestamps
    end

    add_index :amazon_custom_transactions, %i[user_id date_time settlement_id amazon_transaction_type_id order_id sku total], name: :index_amazon_custom_transactions_unique, unique: true
  end
end
