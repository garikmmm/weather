module ForecastLib
  class Client
    def get_forecast(location_id, geolocation_method)
      method = geolocation_method
      if !Location.exists?(location_id)
        method = 2 # force google maps if location is missing from database
      end

      location = Location.find location_id
      if 1 == method.to_i
        latlng_entity = Entity::LatLng.new
        latlng_entity.latitude = location.latitude
        latlng_entity.longitude = location.longitude
      else
        location_name = location.name
        latlng_entity = Util::Geolocation.convert_name_to_lat_lng location_name
      end
      client = ForecastLib::ForecastIoClient.new
      client.get_forecast latlng_entity
    end
  end
end