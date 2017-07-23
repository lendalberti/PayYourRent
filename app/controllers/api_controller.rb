class ApiController < ApplicationController
  require "uri"
  require "net/http"
  

  def create
    if params['zip'].present? && valid_zip(params['zip'])
      zip_code = params['zip'].strip
      api_url = Rails.configuration.weather_api_url
      api_key = params['appid'].present? ? params['appid'] :  Rails.configuration.weather_api_key

      full_api_url = "#{api_url}?zip=#{zip_code}&appid=#{api_key}"
      response = Net::HTTP.get( URI.parse(full_api_url) )
      response = JSON.parse(response) 

      if response['cod'] == 200 
        Forecast.save_weather_data( zip_code, response )
      end
      render :json => { :status_code => response['cod'], :message => response['message'].present? ? response['message'] : '' }
    else
      render :json => { :status_code => 404, :message => "invalid zip code" }
    end
  end




  private

  def valid_zip(zip)
    zip.strip.match(/^\d{5}(?:[-\s]\d{4})?$/)
  end



end
