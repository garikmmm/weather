module ForecastLib
  class Client
    def get_forecast(location_id, geolocation_method)
      location_exists = Location.exists?(location_id)
      if 1 == geolocation_method.to_i and location_exists
        location = Location.find location_id
        location_name = location.name
        latlng_entity = Entity::LatLng.new
        latlng_entity.latitude = location.latitude
        latlng_entity.longitude = location.longitude
      else
        if location_exists
          location = Location.find location_id
          location_name = location.name
        else
          location_name = location_id
        end
        latlng_entity = Util::Geolocation.convert_name_to_lat_lng location_name
      end

      forecast_entity = nil
      if !latlng_entity.nil?
        client = ForecastLib::ForecastIoClient.new
        forecast_entity = client.get_forecast latlng_entity
        forecast_entity.location_id = location_id
        forecast_entity.location_name = location_name
      end
      forecast_entity
    end
  end
end