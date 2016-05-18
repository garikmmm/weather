class WeatherController < ApplicationController

  def index
  end

  def forecast
    location_id = params[:location_id]
    geolocation_method = params[:geolocation_method]


    forecast_entity = Forecast.get_entity_by_location_id location_id # try to get from db
    if forecast_entity.nil?
      client = ForecastLib::Client.new
      forecast_entity = client.get_forecast(location_id, geolocation_method)

      if Location.exists?(location_id)
        forecast = Forecast.new
        forecast.save_entity forecast_entity
      end
    end
    data = {'status': !forecast_entity.nil?, 'data': forecast_entity}
    render json: data
  end

  def autocomplete
    query = params[:query].downcase
    locations = Location.order(:name).where("LOWER(name) LIKE ?", "%#{query}%").limit(10)
    render json:  locations.as_json(:only => [:id, :name])
  end

end
