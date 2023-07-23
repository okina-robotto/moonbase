class CreateAmazonProducts < ActiveRecord::Migration[6.0]
  def change
    execute <<-SQL
      CREATE MATERIALIZED VIEW amazon_products AS
        SELECT DISTINCT(t.sku) AS sku, t.user_id, t.description, m.name AS marketplace
        FROM amazon_custom_transactions t
            LEFT JOIN amazon_marketplaces m ON t.amazon_marketplace_id = m.id
            LEFT JOIN amazon_transaction_types tt on t.amazon_transaction_type_id = tt.id
        WHERE tt.name = 'Order'
        GROUP BY t.sku, t.user_id, t.description, m.name;
    SQL
  end
end
