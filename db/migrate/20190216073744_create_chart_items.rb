class CreateChartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :chart_items do |t|
      t.references :chart, foreign_key: :true
      t.references :item, polymorphic: true
      t.timestamps
    end
  end
end
