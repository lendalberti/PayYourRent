require 'test_helper'
require "uri"
require "net/http"

class ApiControllerTest < ActionDispatch::IntegrationTest

  setup do
    @api_key     = Rails.configuration.weather_api_key
    @api_key_BAD = 'bad_api_key'
    @location1 = forecasts(:boston)
    @location2 = forecasts(:sacramento)
  end

  test "should fail to retrieve current weather conditions when using bad api key" do
    assert_no_difference('Forecast.count') do
      post api_create_url, params: { zip: @location1.zip_code, appid: @api_key_BAD } 
    end
  end 
  test "should fail to retrieve current weather conditions when using bad zip code" do
    assert_no_difference('Forecast.count') do
      post api_create_url, params: { zip: '99999', appid: @api_key } 
    end
  end 


  test "should retrieve current weather conditions for location-1" do
    assert_difference('Forecast.count') do
      post api_create_url, params: { zip: @location1.zip_code, appid: @api_key } 
    end
  end 
  
  test "should retrieve current weather conditions for location-2" do
    assert_difference('Forecast.count') do
      post api_create_url, params: { zip: @location2.zip_code, appid: @api_key }
    end
  end 

  

end
