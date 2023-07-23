class CreateAmazonUsers < ActiveRecord::Migration[6.0]
  def change
    execute <<-SQL
      CREATE MATERIALIZED VIEW amazon_users AS
        SELECT DISTINCT(user_id) FROM amazon_custom_transactions;
    SQL
  end
end
