class CreateAmazonCostOfGoods < ActiveRecord::Migration[6.0]
  def change
    create_table :amazon_cost_of_goods do |t|
      t.uuid :amazon_cost_of_good_id, null: false, default: "uuid_generate_v4()"
      t.uuid :user_id, null: false
      t.references :amazon_marketplace, foreign_key: true, index: { name: :idx_amazon_cost_of_goods_amazon_marketplace_id }
      t.string :sku, null: false
      t.decimal :amount, precision: 10, scale: 2
      t.integer :date_time, null: false
      t.timestamps
    end

    add_index :amazon_cost_of_goods, %i[user_id amazon_marketplace_id sku date_time], name: :amazon_cost_of_goods_unique, unique: true
  end
end
