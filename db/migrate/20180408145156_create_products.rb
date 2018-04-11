class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.integer :category_id
      t.string :game_id
      t.string :name

      t.boolean :deleted, :default => false
      t.timestamps
    end
  end
end
