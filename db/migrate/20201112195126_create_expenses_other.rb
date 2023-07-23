class CreateExpensesOther < ActiveRecord::Migration[6.0]
  def change
    create_table :expenses_others do |t|
      t.uuid :expenses_other_id, null: false, default: "uuid_generate_v4()"
      t.uuid :user_id, null: false
      t.references :currency_exchange_rate, foreign_key: true, index: { name: :idx_expenses_others_currency_exchange_rate_id }
      t.decimal :amount, precision: 10, scale: 2
      t.integer :date_time, null: false
      t.timestamps
    end
  end
end
