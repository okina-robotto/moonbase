class CreateAmazonSponsoredProductsPreviousSixMonths < ActiveRecord::Migration[6.0]
  def change
    execute <<-SQL
      CREATE MATERIALIZED VIEW amazon_sponsored_products_previous_six_months AS
        SELECT user_id,
               date_trunc('week', date_time) AS date_time,
               portfolio_name,
               currency_exchange_rate_id,
               campaign_name,
               ad_group_name,
               sku,
               asin,
               SUM(impressions) AS impressions,
               SUM(clicks) AS clicks,
               SUM(ctr) AS ctr,
               SUM(cpc) AS cpc,
               SUM(spend) AS spend,
               SUM(total_sales) AS total_sales,
               SUM(acos) AS acos,
               SUM(roas) AS roas,
               SUM(total_orders) AS total_orders,
               SUM(total_units) AS total_units,
               AVG(conversion_rate) AS conversion_rate,
               SUM(advertised_sku_units) AS advertised_sku_units,
               SUM(other_sku_units) AS other_sku_units,
               SUM(advertised_sku_sales) AS advertised_sku_sales,
               SUM(other_sku_sales) AS other_sku_sales
        FROM amazon_sponsored_products
        WHERE date_time >= NOW() - interval '12 month'
          AND date_time <= NOW() - interval '6 month'
        GROUP BY user_id, date_trunc('week', date_time), portfolio_name, currency_exchange_rate_id, campaign_name, ad_group_name, sku, asin
        ORDER BY date_trunc('week', date_time), currency_exchange_rate_id ASC;
    SQL
  end
end
