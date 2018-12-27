class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.references :category, foreign_key: true, index: true
      t.string :game_id
      t.string :name
      t.float :avg_amount, default: 1, comment: '平均获得数量(如生活技能物品)'
      t.timestamps
    end
  end
end
