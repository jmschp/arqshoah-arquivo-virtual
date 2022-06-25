# frozen_string_literal: true

class Education < ApplicationRecord
  include FullTextSearch
  include Registration

  belongs_to :education_category, inverse_of: :educations
  belongs_to :venue, class_name: "Organization", inverse_of: :education_events, optional: true

  has_many :education_organizers, inverse_of: :education, dependent: :destroy
  has_many :organizers, through: :education_organizers
  has_many :education_promoter_institutions, inverse_of: :education, dependent: :destroy
  has_many :promoter_institutions, through: :education_promoter_institutions
  has_many :education_supporters, inverse_of: :education, dependent: :destroy
  has_many :organization_supporters, through: :education_supporters, source: :donor, source_type: "Organization"
  has_many :person_supporters, through: :education_supporters, source: :donor, source_type: "Person"

  has_one :teaching_material, inverse_of: :education, dependent: :destroy

  has_rich_text :description
  has_rich_text :observation

  has_one_attached :pdf
  has_many_attached :images

  validates :education_organizers, presence: true
  validates :education_promoter_institutions, presence: true
  validates :education_supporters, presence: true
  validates :end_date, presence: true, comparison: { greater_than_or_equal_to: :start_date }
  validates :online, inclusion: [true, false]
  validates :start_date, presence: true, comparison: { less_than_or_equal_to: :end_date }
  validates :target_public, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validates :venue, presence: true, unless: -> { self.online? }

  accepts_nested_attributes_for :teaching_material, reject_if: :all_blank, allow_destroy: true

  has_paper_trail skip: [:document_ts_vector], on: %i[create destroy update]

  private

  def create_plain_text
    <<~RECORD
      #{self.title}
      #{self.target_public}
      #{self.venue&.name}
      #{self.education_category.name}
      #{self.organizers.pluck(:first_name, :last_name).map { |name| name.join(' ') }.join('; ')}
      #{self.promoter_institutions.pluck(:name).join('; ')}
      #{self.organization_supporters.pluck(:name).join('; ')}
      #{self.person_supporters.pluck(:first_name, :last_name).map { |name| name.join(' ') }.join('; ')}
      #{self.description.to_plain_text}
      #{self.observation.to_plain_text}
      #{self.teaching_material.create_plain_text if self.teaching_material.present?}
    RECORD
  end
end
