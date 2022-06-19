# frozen_string_literal: true

class IconographySupport < ApplicationRecord
  has_many :iconographies, inverse_of: :iconography_support, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
