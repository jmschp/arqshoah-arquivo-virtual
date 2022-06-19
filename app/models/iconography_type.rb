# frozen_string_literal: true

class IconographyType < ApplicationRecord
  has_many :iconographies, inverse_of: :iconography_type, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
