class AddAvgAmountToProduct < ActiveRecord::Migration[5.0]
  def change
  	add_column :products, :avg_amount, 
  end
end
