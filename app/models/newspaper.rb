# frozen_string_literal: true

class Newspaper < ApplicationRecord
  include DateDisplay
  include FullTextSearch
  include LocationGeocode
  include PeopleCitations
  include Registration

  DETAIL_ATTRIBUTES = [
    { type: :direct, attribute: :registration },
    { type: :associated, attribute: :newspaper_type },
    { type: :associated, attribute: :agency },
    { type: :associated, attribute: :author },
    { type: :associated, attribute: :language },
    { type: :direct, attribute: :print_number },
    { type: :date_day, attribute: :date },
    { type: :direct, attribute: :city },
    { type: :direct, attribute: :state },
    { type: :direct, attribute: :country }
  ].freeze

  has_paper_trail skip: [:document_ts_vector], on: %i[create destroy update]

  belongs_to :newspaper_type, inverse_of: :newspapers
  belongs_to :author, class_name: "Person", inverse_of: :authored_newspapers, optional: true
  belongs_to :agency, class_name: "Organization", inverse_of: :published_newspapers, optional: true
  belongs_to :language, inverse_of: :newspapers, optional: true

  has_rich_text :description
  has_rich_text :observation

  has_one_attached :pdf
  has_one_attached :image

  # rubocop:disable Layout/LineLength
  validates :date_day, numericality: { only_integer: true }, length: { minimum: 1, maximum: 2 }, allow_nil: true
  validates :date_month, presence: true, numericality: { only_integer: true }, length: { minimum: 1, maximum: 2 }, if: -> { self.date_day.present? }
  validates :date_year, presence: true, numericality: { only_integer: true }, length: { is: 4 }, if: -> { self.date_month.present? || self.date_day.present? }
  validates :title, presence: true, length: { maximum: 255 }
  # rubocop:enable Layout/LineLength

  private

  def create_plain_text
    <<~RECORD
      #{self.title}
      #{self.location}
      #{self.language&.name}
      #{self.agency&.name}
      #{self.newspaper_type.name}
      #{self.author&.name}
      #{self.people_cited.pluck(:first_name, :last_name).map { |name| "#{name[0]} #{name[1]}" }.join('; ')}
      #{self.description.to_plain_text}
      #{self.observation.to_plain_text}
    RECORD
  end
end
