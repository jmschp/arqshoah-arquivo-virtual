# frozen_string_literal: true

module LocationGeocode
  extend ActiveSupport::Concern

  included do
    geocoded_by :location
    after_validation :geocode, if: :should_geocode?

    reverse_geocoded_by :latitude, :longitude do |obj, results|
      geo = results.first
      if geo
        obj.city = geo.city
        obj.state = geo.state || geo.county
        obj.country = geo.country
      end
    end

    after_validation :reverse_geocode, if: :should_reverse_geocode?
  end

  private

  def should_geocode?
    ENV.fetch("SHOULD_GEOCODE", "true") == "true" && self.location.present? && self.location_changed?
  end

  def should_reverse_geocode?
    ENV.fetch("SHOULD_GEOCODE", "true") == "true" && self.latitude.present? && self.longitude.present? &&
      (self.latitude_changed? || self.longitude_changed?)
  end
end
