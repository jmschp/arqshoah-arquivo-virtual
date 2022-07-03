# frozen_string_literal: true

class Archive < ApplicationRecord
  include DateDisplay
  include FullTextSearch
  include LocationGeocode
  include PeopleCitations
  include Registration

  DETAIL_ATTRIBUTES = [
    { type: :direct, attribute: :registration },
    { type: :associated, attribute: :archive_classification },
    { type: :associated, attribute: :archive_type },
    { type: :direct, attribute: :date },
    { type: :direct, attribute: :city },
    { type: :direct, attribute: :state },
    { type: :direct, attribute: :country },
    { type: :direct, attribute: :document_code },
    { type: :direct, attribute: :document_number },
    { type: :direct, attribute: :page_count },
    { type: :associated, attribute: :language },
    { type: :associated, attribute: :donor }
  ].freeze

  has_paper_trail skip: [:document_ts_vector], on: %i[create destroy update]

  belongs_to :archive_classification, inverse_of: :archives
  belongs_to :archive_type, inverse_of: :archives
  belongs_to :donor, polymorphic: true, inverse_of: :donated_archives
  belongs_to :language, inverse_of: :archives
  belongs_to :issuing_agency, class_name: "Organization", inverse_of: :issued_archives, optional: true
  belongs_to :receiver_agency, class_name: "Organization", inverse_of: :received_archives, optional: true

  has_many :citations, as: :record, inverse_of: :record, dependent: :destroy
  has_many :people_cited, through: :citations, source: :person

  has_one_attached :pdf
  has_many_attached :images

  has_rich_text :description
  has_rich_text :observation

  # rubocop:disable Layout/LineLength
  validates :date_day, numericality: { only_integer: true }, length: { minimum: 1, maximum: 2 }, allow_nil: true
  validates :date_month, presence: true, numericality: { only_integer: true }, length: { minimum: 1, maximum: 2 }, if: -> { self.date_day.present? }
  validates :date_year, presence: true, numericality: { only_integer: true }, length: { is: 4 }, if: -> { self.date_month.present? || self.date_day.present? }
  validates :title, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }
  # rubocop:enable Layout/LineLength

  private

  def create_plain_text
    <<~RECORD
      #{self.title}
      #{self.document_number}
      #{self.document_code}
      #{self.location}
      #{self.donor&.name}
      #{self.issuing_agency&.name}
      #{self.receiver_agency&.name}
      #{self.from_name}
      #{self.from_role}
      #{self.to_name}
      #{self.to_role}
      #{self.archive_classification.name}
      #{self.archive_type.name}
      #{self.language.name}
      #{self.people_cited.pluck(:first_name, :last_name).map { |name| "#{name[0]} #{name[1]}" }.join('; ')}
      #{self.description.to_plain_text}
      #{self.observation.to_plain_text}
    RECORD
  end
end
