# frozen_string_literal: true

class Education < ApplicationRecord
  belongs_to :education_category, inverse_of: :educations
  belongs_to :venue, class_name: "Organization", inverse_of: :education_events

  has_many :education_organizers, inverse_of: :education, dependent: :destroy
  has_many :organizers, through: :education_organizers
  has_many :education_promoter_institutions, inverse_of: :education, dependent: :destroy
  has_many :promoter_institution, through: :education_promoter_institutions
  has_many :education_supporters, inverse_of: :education, dependent: :destroy
  has_many :organization_supporters, through: :education_supporters, source: :donor, source_type: "Organization"
  has_many :person_supporters, through: :education_supporters, source: :donor, source_type: "Person"

  has_one :teaching_material, inverse_of: :education, dependent: :destroy

  has_rich_text :description
  has_rich_text :observation

  has_one_attached :flyer
  has_many_attached :images
end
