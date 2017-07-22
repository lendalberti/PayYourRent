require 'test_helper'
require "uri"
require "net/http"

class ApiControllerTest < ActionDispatch::IntegrationTest

  setup do
    @api_url   = Rails.configuration.weather_api_url
    @api_key   = Rails.configuration.weather_api_key
    @location1 = forecasts(:boston)
    @location2 = forecasts(:sacramento)
  end



  test 'Should generate exception if no api URL is provided' do
    assert_raise do
      WeatherApi.new nil
    end
    assert_raise do
      WeatherApi.new ''
    end
  end


  test "Should retrieve current weather conditions for location-1" do
    postParams = { zip: @location1.zip_code }
    full_api_url = "#{@api_url}?zip=#{@location1.zip_code}&appid=#{@api_key}"

    response = Net::HTTP.post_form( URI.parse(full_api_url), postParams)
    body = JSON.parse response.body

    assert_equal body['cod'], 200
    assert_equal body['coord']['lon'],   @location1.longitude.to_f
    assert_equal body['coord']['lat'],   @location1.latitude.to_f
    assert_equal body['name'],           @location1.city_name
    assert_equal body['sys']['country'], @location1.country
  end 
  
  test "Should retrieve current weather conditions for location-2" do
    postParams = { zip: @location2.zip_code }
    full_api_url = "#{@api_url}?zip=#{@location2.zip_code}&appid=#{@api_key}"

    response = Net::HTTP.post_form( URI.parse(full_api_url), postParams)
    body = JSON.parse(response.body)

    assert_equal body['cod'], 200
    assert_equal body['coord']['lon'],   @location2.longitude.to_f
    assert_equal body['coord']['lat'],   @location2.latitude.to_f
    assert_equal body['name'],           @location2.city_name
    assert_equal body['sys']['country'], @location2.country
  end 


end