class AddAvgAmountToProduct < ActiveRecord::Migration[5.0]
  def change
  	add_column :products, :avg_amount, :decimal, precision: 8, scale: 2, default: 1
  end
end
