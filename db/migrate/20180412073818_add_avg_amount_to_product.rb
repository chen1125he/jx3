class AddAvgAmountToProduct < ActiveRecord::Migration[5.0]
  def change
  	add_column :products, :avg_amount, :decimal, precision: 12, scale: 4, default: 1
  end
end
