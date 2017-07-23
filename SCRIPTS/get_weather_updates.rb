require "uri"
require "net/http"
require "base64"
require "byebug"

require File.expand_path('../../config/environment', __FILE__)

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
    results = Forecast.save_weather_data( zip_code, response )
  else
    puts "Error; code=[#{response['cod']}], #{response['message']}"
  end

end
