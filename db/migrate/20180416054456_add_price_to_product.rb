class AddPriceToProduct < ActiveRecord::Migration[5.0]
  def change
  	add_column :products, :price, :decimal, :precision => 12, :scale => 4
  end
end
