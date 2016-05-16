class Forecast < ActiveRecord::Base
  belongs_to :location

  def self.get_entity_by_location_id(location_id)
    info_from_db = self.find_by_location_id location_id
    if info_from_db
      entity = Entity::Forecast.new
      entity.currently = JSON.parse(info_from_db.currently)
      entity.minutely = JSON.parse(info_from_db.minutely)
      entity.hourly = JSON.parse(info_from_db.hourly)
      entity.daily = JSON.parse(info_from_db.daily)
      entity.postal_code = info_from_db.postal_code
      entity
    else
      nil
    end
  end


  def save_entity(forecast_entity)
    self.currently = JSON.generate(forecast_entity.currently)
    self.minutely = JSON.generate(forecast_entity.minutely)
    self.hourly = JSON.generate(forecast_entity.hourly)
    self.daily = JSON.generate(forecast_entity.daily)
    self.postal_code = forecast_entity.postal_code
    self.save
  end
end
