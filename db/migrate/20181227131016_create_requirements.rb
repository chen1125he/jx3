class CreateRequirements < ActiveRecord::Migration[5.1]
  def change
    create_table :requirements do |t|
      t.references :owner, index: true, foreign_key: { to_table: :products }
      t.references :material, index: true, foreign_key: { to_table: :products }
      t.float :amount
      t.timestamps
    end
  end
end
