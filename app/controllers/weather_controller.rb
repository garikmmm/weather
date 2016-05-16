class WeatherController < ApplicationController

  def index
  end

  def forecast
    postal_code = params[:location_id]
    forecast_entity = Forecast.get_entity_by_location_id location_id
    forecast_entity = nil
    if !forecast_entity
      client = ForecastIo::Client.new
      forecast_entity = client.get_forecast postal_code
      forecast = Forecast.new
      forecast.save_entity forecast_entity

    end
    render json: forecast_entity
  end

  def autocomplete
    query = params[:query].downcase
    locations = Location.order(:name).where("LOWER(name) LIKE ?", "%#{query}%").limit(5)
    render json:  locations.as_json(:only => [:id, :name])
  end

end
