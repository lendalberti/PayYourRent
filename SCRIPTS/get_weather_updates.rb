require "uri"
require "net/http"
require "base64"
require "byebug"

require File.expand_path('../../config/environment', __FILE__)


def save_weather_data(zip_code, w)
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
      
API_URL = Rails.configuration.weather_api_url
API_KEY = Rails.configuration.weather_api_key

if ARGV[0].nil?
  puts "Error: missing zip code..."
  exit
else
  puts "* #{ARGV[0]} -- #{Time.now}"
  zip_code = ARGV[0]
  full_api_url = "#{API_URL}?zip=#{zip_code}&appid=#{API_KEY}"
  response = Net::HTTP.get( URI.parse(full_api_url) )
  response = JSON.parse(response) 

  if response['cod'] == 200 
    results = save_weather_data( zip_code, response )
  else
    puts "Error; code=[#{response['cod']}], #{response['message']}"
  end

end
