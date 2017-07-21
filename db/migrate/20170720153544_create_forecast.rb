class CreateForecast < ActiveRecord::Migration[5.0]
  def change
    create_table :forecasts do |t|
      t.string :zip_code
      t.string :conditions_main
      t.string :conditions_desc
      t.string :longitude
      t.string :latitude
      t.string :city_name
      t.string :country
      t.string :pressure
      t.string :temp_k
      t.string :wind_direction
      t.string :wind_speed
      t.string :humidity
      t.string :timestamp
    end
  end
end
