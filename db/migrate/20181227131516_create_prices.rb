class CreatePrices < ActiveRecord::Migration[5.1]
  def change
    create_table :prices do |t|
      t.references :owner, index: true, foreign_key: { to_table: :products }
      t.references :service, index: true
      t.string :price_type, comment: '是否是固定的，否则有价格历史'
      t.string :currency_type, comment: '价格的货币类型'
      t.decimal :amount, precision: 12, scale: 4, default: 0
      t.string :seller_name, comment: '售卖者'
      t.date :record_date, comment: '此价格的时间'
      t.timestamps
    end
  end
end
