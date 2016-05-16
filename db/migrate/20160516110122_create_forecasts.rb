class CreateForecasts < ActiveRecord::Migration
  def change
    create_table :forecasts do |t|
      t.text :currently
      t.text :minutely
      t.text :hourly
      t.text :daily
      t.references :location, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
