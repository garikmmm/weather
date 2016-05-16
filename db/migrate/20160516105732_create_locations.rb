class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name, limit: 100
      t.decimal :latitude, scale: 8, precision: 11
      t.decimal :longitude, scale: 8, precision: 11
      t.boolean :is_postal

      t.timestamps null: false
    end
  end
end
