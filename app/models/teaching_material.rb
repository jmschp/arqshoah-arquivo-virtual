# frozen_string_literal: true

class TeachingMaterial < ApplicationRecord
  belongs_to :education, inverse_of: :teaching_material
  belongs_to :teaching_material_type, inverse_of: :education
  belongs_to :publishing_company, class_name: "Organization", inverse_of: :published_teaching_materials

  has_many :teaching_material_authors, inverse_of: :teaching_material, dependent: :destroy
  has_many :authors, through: :teaching_material_authors

  has_one_attached :pdf

  validates :title, presence: true, length: { maximum: 255 }
  validates :publication_year, presence: true, numericality: { only_integer: true }, length: { is: 4 }
  validates :teaching_material_authors, presence: true

  def create_plain_text
    <<~RECORD
      #{self.title}
      #{self.teaching_material_type.name}
      #{self.publishing_company.name}
      #{self.authors.pluck(:first_name, :last_name).map { |name| name.join(' ') }&.join('; ')}
    RECORD
  end
end
