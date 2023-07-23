class CreateCurrencyExchangeRates < ActiveRecord::Migration[6.0]
  def change
    create_table :currency_exchange_rates do |t|
      t.uuid :currency_exchange_rate_id, null: false, default: "uuid_generate_v4()"
      t.string :code, null: false, index: { unique: true }
      t.decimal :exchange_rate, precision: 10, scale: 2
      t.timestamps
    end
  end
end
