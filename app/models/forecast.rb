class Forecast < ActiveRecord::Base
  belongs_to :location

  def self.get_entity_by_location_id(location_id)
    info_from_db = self.find_by_location_id location_id
    if !info_from_db.nil?
      entity = Entity::Forecast.new
      entity.currently = JSON.parse(info_from_db.currently) if !info_from_db.currently.nil?
      entity.minutely = JSON.parse(info_from_db.minutely) if !info_from_db.minutely.nil?
      entity.hourly = JSON.parse(info_from_db.hourly) if !info_from_db.hourly.nil?
      entity.daily = JSON.parse(info_from_db.daily) if !info_from_db.daily.nil?
      entity.location_id = info_from_db.location_id
      entity
    else
      nil
    end
  end


  def save_entity(forecast_entity)
    self.currently = JSON.generate(forecast_entity.currently) if !forecast_entity.currently.nil?
    self.minutely = JSON.generate(forecast_entity.minutely) if !forecast_entity.minutely.nil?
    self.hourly = JSON.generate(forecast_entity.hourly) if !forecast_entity.hourly.nil?
    self.daily = JSON.generate(forecast_entity.daily) if !forecast_entity.daily.nil?
    self.location_id = forecast_entity.location_id
    self.save
  end
end
