class CreateProductToProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :product_to_products do |t|
      t.integer :product_id
      t.integer :required_id
      t.integer :amount, :default => 1
      t.timestamps
    end
  end
end
