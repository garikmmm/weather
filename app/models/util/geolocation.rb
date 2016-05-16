module Util
  class Geolocation
    def self.convert_postal_to_lat_lng(postal_code)


      if 'OK' == geolocation_data['status'].to_s

        ltln = Entity::LatLng.new
        ltln.lat = 37.8267
        ltln.lng = -122.423
        ltln
      else
        nil
      end

    end
  end
end