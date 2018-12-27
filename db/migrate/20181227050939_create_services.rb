class CreateServices < ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|
      t.references :area, index: true, foreign_key: true
      t.string :name
      t.timestamps
    end
  end
end
