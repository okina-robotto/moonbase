class CreateAmazonCustomTransactionsPreviousThirtyDays < ActiveRecord::Migration[6.0]
  def change
    execute <<-SQL
      CREATE MATERIALIZED VIEW amazon_custom_transactions_previous_thirty_days AS
        SELECT user_id,
               date_trunc('day', date_time) AS date_time,
               amazon_transaction_type_id,
               sku,
               SUM(quantity) AS quantity,
               amazon_marketplace_id,
               SUM(product_sales) AS product_sales,
               SUM(product_sales_tax) AS product_sales_tax,
               SUM(shipping_credits) AS shipping_credits,
               SUM(shipping_credits_tax) AS shipping_credits_tax,
               SUM(giftwrap_credits) AS giftwrap_credits,
               SUM(giftwrap_credits_tax) AS giftwrap_credits_tax,
               SUM(promotional_rebates) AS promotional_rebates,
               SUM(promotional_rebates_tax) AS promotional_rebates_tax,
               SUM(marketplace_withheld_tax) AS marketplace_withheld_tax,
               SUM(selling_fees) AS selling_fees,
               SUM(fba_fees) AS fba_fees,
               SUM(other_transaction_fees) AS other_transaction_fees,
               SUM(other) AS other,
               SUM(total) AS total
        FROM amazon_custom_transactions
        WHERE date_time >= date_trunc('day', NOW()) - interval '60 day'
          AND date_time <= date_trunc('day', NOW()) - interval '30 day' - interval '1 second'
        GROUP BY user_id, date_trunc('day', date_time), amazon_transaction_type_id, sku, amazon_marketplace_id
        ORDER BY date_trunc('day', date_time), amazon_marketplace_id ASC;
    SQL
  end
end
