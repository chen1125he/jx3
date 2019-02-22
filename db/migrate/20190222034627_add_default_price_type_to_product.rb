class AddDefaultPriceTypeToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :price_type, :string, comment: '默认使用的价格类型'
  end
end
