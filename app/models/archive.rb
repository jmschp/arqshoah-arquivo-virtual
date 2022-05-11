# frozen_string_literal: true

class Archive < ApplicationRecord
  # rubocop:disable Metrics/LineLength
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

  validates :date_day, numericality: { only_integer: true }, length: { minimum: 1, maximum: 2 }, allow_nil: true
  validates :date_month, presence: true, numericality: { only_integer: true }, length: { minimum: 1, maximum: 2 }, if: -> { self.date_day.present? }
  validates :date_year, presence: true, numericality: { only_integer: true }, length: { is: 4 }, if: -> { self.date_month.present? || self.date_day.present? }
  validates :title, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }
  # rubocop:enable Metrics/LineLength
end
