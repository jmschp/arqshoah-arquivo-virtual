# frozen_string_literal: true

class EducationCategory < ApplicationRecord
  has_many :educations, inverse_of: :education_category, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
