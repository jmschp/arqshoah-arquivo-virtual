# frozen_string_literal: true

class Person < ApplicationRecord
  include DateDisplay
  include FullTextSearch
  include Registration

  # rubocop:disable Metrics/LineLength
  belongs_to :father, class_name: "Person", optional: true
  belongs_to :mother, class_name: "Person", optional: true
  belongs_to :spouse, class_name: "Person", optional: true
  belongs_to :religion, optional: true

  has_many :authored_iconographies, class_name: "Iconography", foreign_key: "author_id", inverse_of: :author, dependent: :restrict_with_error
  has_many :authored_newspapers, class_name: "Newspaper", foreign_key: "author_id", inverse_of: :author, dependent: :restrict_with_error
  has_many :citations, inverse_of: :person, dependent: :destroy
  has_many :archive_citation, through: :citations, source: :record, source_type: "Archive"
  has_many :donated_archives, as: :donor, class_name: "Archive", inverse_of: :donor, dependent: :restrict_with_error
  has_many :donated_iconographies, as: :donor, class_name: "Iconography", inverse_of: :donor, dependent: :restrict_with_error
  has_many :interviews_given, class_name: "Interview", foreign_key: "interviewed_id", inverse_of: :interviewed, dependent: :destroy
  has_many :interviews_made, class_name: "Interview", foreign_key: "interviewer_id", inverse_of: :interviewer, dependent: :destroy

  has_one_attached :pdf
  has_many_attached :images

  has_rich_text :other_family_members
  has_rich_text :professional_activities
  has_rich_text :description
  has_rich_text :observation

  enum :gender, male: 0, female: 1

  accepts_nested_attributes_for :interviews_given, allow_destroy: true, reject_if: :all_blank

  after_validation :geocode_birth_place, if: :should_geocode_birth_place?
  after_validation :geocode_death_place, if: :should_geocode_death_place?

  validates :birth_date_day, numericality: { only_integer: true }, length: { minimum: 1, maximum: 2 }, allow_nil: true, unless: -> { self.commoner? }
  validates :birth_date_month, presence: true, numericality: { only_integer: true }, length: { minimum: 1, maximum: 2 }, if: -> { !self.commoner? && self.birth_date_day.present? }
  validates :birth_date_year, presence: true, numericality: { only_integer: true }, length: { is: 4 }, if: -> { !self.commoner? && self.birth_date_month.present? || self.birth_date_day.present? }
  validates :death_date_day, numericality: { only_integer: true }, length: { minimum: 1, maximum: 2 }, allow_nil: true, unless: -> { self.commoner? }
  validates :death_date_month, presence: true, numericality: { only_integer: true }, length: { minimum: 1, maximum: 2 }, if: -> { !self.commoner? && self.death_date_day.present? }
  validates :death_date_year, presence: true, numericality: { only_integer: true }, length: { is: 4 }, if: -> { !self.commoner? && self.death_date_month.present? || self.death_date_day.present? }
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :gender, presence: true, unless: -> { self.commoner? }

  ransack_alias :name, :first_name_or_last_name_or_name_variation
  # rubocop:enable Metrics/LineLength

  def self.select_options_name
    self.order(:last_name).pluck(:first_name, :last_name, :id).map do |person|
      ["#{person[1].upcase} #{person[0]}", person[2]]
    end
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end

  private

  def commoner?
    self.type == "Commoner"
  end

  def create_plain_text
    <<~RECORD
      #{self.first_name} #{self.last_name}
      #{self.name_variation}
      #{self.birth_place}
      #{self.death_place}
      #{self.academic_formation}
      #{self.religion&.name}
      #{self.spouse&.name}
      #{self.mother&.name}
      #{self.father&.name}
      #{self.other_family_members.to_plain_text}
      #{self.professional_activities.to_plain_text}
      #{self.description.to_plain_text}
      #{self.observation.to_plain_text}
    RECORD
  end

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
