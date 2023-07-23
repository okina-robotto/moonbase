class CreateAmazonTransactionTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :amazon_transaction_types do |t|
      t.string :name, null: false, index: { unique: true }
      t.timestamps
    end
  end
end
