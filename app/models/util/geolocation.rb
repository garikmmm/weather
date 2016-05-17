module Util
  class Geolocation
    def self.convert_name_to_lat_lng(location_name)
      uri_string = 'http://maps.googleapis.com/maps/api/geocode/json?sensor=false&address=' + location_name
      uri = URI(uri_string)
      str = Net::HTTP.get(uri) # => String
      geolocation_data = JSON.parse(str.to_s)

      if 'OK' == geolocation_data['status'].to_s
        location = geolocation_data['results'][0]['geometry']['location']
        ltln = Entity::LatLng.new
        ltln.latitude = location['lat']
        ltln.longitude = location['lng']
        ltln
      else
        nil
      end

    end
  end
end