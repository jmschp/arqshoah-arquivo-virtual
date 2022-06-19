# frozen_string_literal: true

class Organization < ApplicationRecord
  include LocationGeocode

  # rubocop:disable Metrics/LineLength
  has_many :donated_archives, as: :donor, class_name: "Archive", inverse_of: :donor, dependent: :restrict_with_error
  has_many :donated_iconographies, as: :donor, class_name: "Iconography", inverse_of: :donor, dependent: :restrict_with_error
  has_many :issued_archives, class_name: "Archive", inverse_of: :issuing_agency, dependent: :restrict_with_error
  has_many :received_archives, class_name: "Archive", inverse_of: :receiver_agency, dependent: :restrict_with_error
  # rubocop:enable Metrics/LineLength

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
