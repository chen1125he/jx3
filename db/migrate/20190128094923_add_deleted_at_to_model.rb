class AddDeletedAtToModel < ActiveRecord::Migration[5.2]
  def change
    add_column :areas, :deleted_at, :datetime
    add_column :categories, :deleted_at, :datetime
    add_column :products, :deleted_at, :datetime
    add_column :services, :deleted_at, :datetime
  end
end
