require 'net/http'
require 'json'

module ForecastLib
  class ForecastIoClient
    def get_forecast(latlng_entity)
      uri_string = 'https://api.forecast.io/forecast/' + Rails.application.config.x.forecast_api_key.to_s + '/' + latlng_entity.latitude.to_s + ',' + latlng_entity.longitude.to_s
      uri = URI(uri_string)
      str = Net::HTTP.get(uri) # => String
      forecast_hash = JSON.parse(str.to_s)
      forecast_entity = Entity::Forecast.new
      forecast_entity.currently = forecast_hash['currently']
      forecast_entity.minutely = forecast_hash['minutely']
      forecast_entity.hourly = forecast_hash['hourly']
      forecast_entity.daily = forecast_hash['daily']
      forecast_entity
    end
  end
end