# frozen_string_literal: true

class Iconography < ApplicationRecord
  include DateDisplay
  include FullTextSearch
  include LocationGeocode
  include PeopleCitations
  include Registration

  DETAIL_ATTRIBUTES = [
    { type: :direct, attribute: :registration },
    { type: :associated, attribute: :iconography_support },
    { type: :associated, attribute: :iconography_technic },
    { type: :associated, attribute: :iconography_type },
    { type: :associated, attribute: :author },
    { type: :direct, attribute: :date },
    { type: :direct, attribute: :city },
    { type: :direct, attribute: :state },
    { type: :direct, attribute: :country },
    { type: :direct, attribute: :nature_of_object },
    { type: :associated, attribute: :donor }
  ].freeze

  belongs_to :author, class_name: "Person", inverse_of: :authored_iconographies, optional: true
  belongs_to :donor, polymorphic: true, inverse_of: :donated_iconographies
  belongs_to :iconography_support, inverse_of: :iconographies
  belongs_to :iconography_technic, inverse_of: :iconographies
  belongs_to :iconography_type, inverse_of: :iconographies

  has_many :book_iconographies, inverse_of: :iconography, dependent: :destroy
  has_many :books, through: :book_iconographies
  has_many :citations, as: :record, inverse_of: :record, dependent: :destroy
  has_many :people_cited, through: :citations, source: :person

  has_rich_text :description
  has_rich_text :observation

  has_one_attached :image

  # rubocop:disable Layout/LineLength
  validates :date_day, numericality: { only_integer: true }, length: { minimum: 1, maximum: 2 }, allow_nil: true
  validates :date_month, presence: true, numericality: { only_integer: true }, length: { minimum: 1, maximum: 2 }, if: -> { self.date_day.present? }
  validates :date_year, presence: true, numericality: { only_integer: true }, length: { is: 4 }, if: -> { self.date_month.present? || self.date_day.present? }
  validates :image, presence: true
  validates :original, inclusion: [true, false]
  validates :title, presence: true, length: { maximum: 255 }
  # rubocop:enable Layout/LineLength

  has_paper_trail skip: [:document_ts_vector], on: %i[create update destroy]

  def nature_of_object
    self.original? ? self.class.human_attribute_name(:original) : self.class.human_attribute_name(:replica)
  end

  private

  def create_plain_text
    <<~RECORD
      #{self.title}
      #{self.subtitle}
      #{self.location}
      #{self.donor&.name}
      #{self.iconography_technic.name}
      #{self.iconography_type.name}
      #{self.iconography_support.name}
      #{self.people_cited.pluck(:first_name, :last_name).map { |name| "#{name[0]} #{name[1]}" }.join('; ')}
      #{self.description.to_plain_text}
      #{self.observation.to_plain_text}
    RECORD
  end
end
