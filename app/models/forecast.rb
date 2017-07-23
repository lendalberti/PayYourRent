class Forecast < ApplicationRecord

  def self.save_weather_data(zip_code, w)
    forecast = Forecast.new
    forecast.zip_code        = zip_code
    forecast.conditions_main = w['weather'][0]['main']
    forecast.conditions_desc = w['weather'][0]['description']
    forecast.longitude       = w['coord']['lon']
    forecast.latitude        = w['coord']['lat']
    forecast.city_name       = w['name']
    forecast.country         = w['sys']['country']
    forecast.pressure        = w['main']['pressure']
    forecast.temp_k          = w['main']['temp']
    forecast.wind_direction  = w['wind']['deg']
    forecast.wind_speed      = w['wind']['speed']
    forecast.humidity        = w['main']['humidity']
    forecast.timestamp       = w['dt']
    return forecast.save
  end

end
