class WeatherController < ApplicationController

  def index
  end

  def forecast
    location_id = params[:location_id]
    geolocation_method = params[:geolocation_method]


    forecast_entity = Forecast.get_entity_by_location_id location_id # try to get from db
    if !forecast_entity
      client = ForecastLib::Client.new
      forecast_entity = client.get_forecast(location_id, geolocation_method)
      forecast_entity.location_id = location_id

      if Location.exists?(location_id)
        forecast = Forecast.new
        forecast.save_entity forecast_entity
      end
    end
    render json: forecast_entity
  end

  def autocomplete
    query = params[:query].downcase
    locations = Location.order(:name).where("LOWER(name) LIKE ?", "%#{query}%").limit(5)
    render json:  locations.as_json(:only => [:id, :name])
  end

end
