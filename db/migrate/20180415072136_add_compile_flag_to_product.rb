class AddCompileFlagToProduct < ActiveRecord::Migration[5.0]
  def change
  	add_column :products, :compile_flag, :boolean, :default => false
  	add_column :products, :vigor_cost, :decimal, :precision => 6, :scale => 2
  end
end
