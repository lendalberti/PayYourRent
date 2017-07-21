class ApiController < ApplicationController
  require "uri"
  require "net/http"
  

  def create
    if params['zip'].present? && valid_zip(params['zip'])
      api_url = Rails.configuration.weather_api_url
      api_key = Rails.configuration.weather_api_key
      zip_code = params['zip']

      full_api_url = "#{api_url}?zip=#{zip_code}&appid=#{api_key}"
      response = Net::HTTP.get( URI.parse(full_api_url) )
      response = JSON.parse(response) 

      if response['cod'] == 200 
        save_weather_data( zip_code, response )
      end
      render :json => { :status_code => response['cod'], :message => response['message'].present? ? response['message'] : '' }
    else
      render :json => { :status_code => 404, :message => "invalid zip code" }
    end
  end





  private

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


  def valid_zip(zip)
    zip.match(/^\d{5}(?:[-\s]\d{4})?$/)
  end



end
