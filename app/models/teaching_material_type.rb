# frozen_string_literal: true

class TeachingMaterialType < ApplicationRecord
  has_many :teaching_materials, inverse_of: :teaching_material_type, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
