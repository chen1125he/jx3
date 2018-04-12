class AddDeletedToPtp < ActiveRecord::Migration[5.0]
  def change
  	add_column :product_to_products, :deleted, :boolean, :default => false
  end
end
