# frozen_string_literal: true

class TeachingMaterialAuthor < ApplicationRecord
  belongs_to :author, class_name: "Person", inverse_of: :teaching_material_authors
  belongs_to :teaching_material, inverse_of: :teaching_material_authors
end
