class CreatePrices < ActiveRecord::Migration[5.0]
  def change
    create_table :prices do |t|
      t.integer :product_id
      t.decimal :amount, :precision => 11, :scale => 2
      t.string :seller_name
      t.datetime :record_time
      t.boolean :deleted, :default => false
      t.timestamps
    end
  end
end
