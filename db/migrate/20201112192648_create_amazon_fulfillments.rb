class CreateAmazonFulfillments < ActiveRecord::Migration[6.0]
  def change
    create_table :amazon_fulfillments do |t|
      t.string :name, null: false, index: { unique: true }
      t.timestamps
    end
  end
end
