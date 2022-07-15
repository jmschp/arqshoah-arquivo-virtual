# frozen_string_literal: true

module LocationGeocode
  extend ActiveSupport::Concern

  included do
    after_validation :geocode_birth_place, if: :should_geocode_birth_place?
    after_validation :geocode_death_place, if: :should_geocode_death_place?
  end

  private

  def geocode_birth_place
    birth_place_lat_lon = Geocoder.search(self.birth_place).first&.coordinates
    self.birth_place_latitude = birth_place_lat_lon[0]
    self.birth_place_longitude = birth_place_lat_lon[1]

    return unless self.should_reverse_geocode_birth_place?

    result = Geocoder.search([self.birth_place_latitude, self.birth_place_longitude]).first
    self.birth_place_city = result.city || result.town
    self.birth_place_state = result.state || result.county
    self.birth_place_country = result.country
  end

  def geocode_death_place
    death_place_lat_lon = Geocoder.search(self.death_place).first&.coordinates
    self.death_place_latitude = death_place_lat_lon[0]
    self.death_place_longitude = death_place_lat_lon[1]

    return unless self.should_reverse_geocode_death_place?

    result = Geocoder.search([self.death_place_latitude, self.death_place_longitude]).first
    self.death_place_city = result.city || result.town
    self.death_place_state = result.state || result.county
    self.death_place_country = result.country
  end

  def should_geocode_birth_place?
    ENV.fetch("SHOULD_GEOCODE", "true") == "true" && self.birth_place.present? && self.birth_place_changed?
  end

  def should_reverse_geocode_birth_place?
    self.birth_place_latitude.present? && self.birth_place_longitude.present? &&
      (self.birth_place_latitude_changed? || self.birth_place_longitude_changed?)
  end

  def should_geocode_death_place?
    ENV.fetch("SHOULD_GEOCODE", "true") == "true" && self.death_place.present? && self.death_place_changed?
  end

  def should_reverse_geocode_death_place?
    self.death_place_latitude.present? && self.death_place_longitude.present? &&
      (self.death_place_latitude_changed? || self.death_place_longitude_changed?)
  end
end
