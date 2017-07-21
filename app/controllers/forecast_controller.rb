class ForecastController < ApplicationController
  helper_method :wind_direction
  helper_method :kelvin_to_fahr

  def index
    @forecasts = Forecast.order('id DESC')
  end

  
  def wind_direction(compass)
    # http://www.shastadefense.com/C-RefMaterialWindDirection820.pdf  
    degrees = compass.to_i

    if degrees.between?(0,45)
      direction = "N-NE" 
    elsif degrees.between?(46,90)
      direction = "E-NE"
    elsif degrees.between?(91,135)
      direction = "E-SE"
    elsif degrees.between?(136,180)
      direction = "S-SE"
    elsif degrees.between?(181,225)
      direction = "S-SW" 
    elsif degrees.between?(226,270)
      direction = "W-SW"
    elsif degrees.between?(271,315)
      direction = "W-NW"
    elsif degrees.between?(316,360)
      direction = "N-NW"
    end
  end

  def kelvin_to_fahr(k)
    ((k.to_f * 9/5) - 459.67).round(1)
  end




end