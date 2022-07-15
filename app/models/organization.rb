# frozen_string_literal: true

class Organization < ApplicationRecord
  include LocationGeocode

  # rubocop:disable Layout/LineLength
  has_many :donated_archives, as: :donor, class_name: "Archive", inverse_of: :donor, dependent: :restrict_with_error
  has_many :donated_iconographies, as: :donor, class_name: "Iconography", inverse_of: :donor, dependent: :restrict_with_error
  has_many :issued_archives, class_name: "Archive", foreign_key: :issuing_agency_id, inverse_of: :issuing_agency, dependent: :restrict_with_error
  has_many :received_archives, class_name: "Archive", foreign_key: :receiver_agency_id, inverse_of: :receiver_agency, dependent: :restrict_with_error
  has_many :published_newspapers, class_name: "Newspaper", inverse_of: :agency, foreign_key: :agency_id, dependent: :restrict_with_error
  has_many :published_books, class_name: "Book", foreign_key: :publishing_company_id, inverse_of: :publishing_company, dependent: :restrict_with_error
  has_many :education_events, class_name: "Education", foreign_key: :venue_id, inverse_of: :venue, dependent: :restrict_with_error
  has_many :education_promoter_institutions, foreign_key: :promoter_institution_id, inverse_of: :promoter_institution, dependent: :destroy
  has_many :promoted_education, through: :education_promoter_institutions, source: :education
  has_many :education_supporters, as: :donor, inverse_of: :donor, dependent: :destroy
  has_many :supported_education, through: :education_supporters, source: :education
  has_many :published_teaching_materials, class_name: "TeachingMaterial", foreign_key: :publishing_company_id, inverse_of: :publishing_company, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }

  scope :book_publishing_companies, -> { joins(:published_books).order(:name).distinct }
  scope :issuer_agencies, -> { joins(:issued_archives).order(:name).distinct }
  scope :receiver_agencies, -> { joins(:received_archives).order(:name).distinct }
  scope :newspaper_publishers, -> { joins(:published_newspapers).order(:name).distinct }
  # rubocop:enable Layout/LineLength
end
