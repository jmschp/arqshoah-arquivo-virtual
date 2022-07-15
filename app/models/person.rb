# frozen_string_literal: true

class Person < ApplicationRecord
  include DateDisplay
  include FullTextSearch
  include Registration

  # rubocop:disable Layout/LineLength
  belongs_to :father, class_name: "Person", optional: true
  belongs_to :mother, class_name: "Person", optional: true
  belongs_to :spouse, class_name: "Person", optional: true
  belongs_to :religion, optional: true

  has_many :book_authors, foreign_key: "author_id", inverse_of: :author, dependent: :destroy
  has_many :authored_books, through: :book_authors
  has_many :authored_iconographies, class_name: "Iconography", foreign_key: "author_id", inverse_of: :author, dependent: :restrict_with_error
  has_many :authored_newspapers, class_name: "Newspaper", foreign_key: "author_id", inverse_of: :author, dependent: :restrict_with_error
  has_many :citations, inverse_of: :person, dependent: :destroy
  has_many :archive_citation, through: :citations, source: :record, source_type: "Archive"
  has_many :donated_archives, as: :donor, class_name: "Archive", inverse_of: :donor, dependent: :restrict_with_error
  has_many :donated_iconographies, as: :donor, class_name: "Iconography", inverse_of: :donor, dependent: :restrict_with_error
  has_many :interviews_given, class_name: "Interview", foreign_key: "interviewed_id", inverse_of: :interviewed, dependent: :destroy
  has_many :interviews_made, class_name: "Interview", foreign_key: "interviewer_id", inverse_of: :interviewer, dependent: :destroy
  has_many :education_organizers, inverse_of: :organizer, foreign_key: :organizer_id, dependent: :destroy
  has_many :organized_educations, through: :education_organizers, source: :education
  has_many :education_supporters, as: :donor, inverse_of: :donor, dependent: :destroy
  has_many :supported_education, through: :education_supporters, source: :education
  has_many :teaching_material_authors, inverse_of: :author, dependent: :restrict_with_error
  has_many :authored_teaching_materials, through: :teaching_material_authors, source: :teaching_material

  has_one_attached :pdf
  has_many_attached :images

  has_rich_text :other_family_members
  has_rich_text :professional_activities
  has_rich_text :description
  has_rich_text :observation

  enum :gender, male: 0, female: 1

  accepts_nested_attributes_for :interviews_given, allow_destroy: true, reject_if: :all_blank

  validates :birth_date_day, numericality: { only_integer: true }, length: { minimum: 1, maximum: 2 }, allow_nil: true, unless: -> { self.commoner? }
  validates :birth_date_month, presence: true, numericality: { only_integer: true }, length: { minimum: 1, maximum: 2 }, if: -> { !self.commoner? && self.birth_date_day.present? }
  validates :birth_date_year, presence: true, numericality: { only_integer: true }, length: { is: 4 }, if: -> { (!self.commoner? && self.birth_date_month.present?) || self.birth_date_day.present? }
  validates :birth_date, comparison: { less_than: :death_date }, allow_nil: true
  validates :death_date_day, numericality: { only_integer: true }, length: { minimum: 1, maximum: 2 }, allow_nil: true, unless: -> { self.commoner? }
  validates :death_date_month, presence: true, numericality: { only_integer: true }, length: { minimum: 1, maximum: 2 }, if: -> { !self.commoner? && self.death_date_day.present? }
  validates :death_date_year, presence: true, numericality: { only_integer: true }, length: { is: 4 }, if: -> { (!self.commoner? && self.death_date_month.present?) || self.death_date_day.present? }
  validates :death_date, comparison: { greater_than: :birth_date }, allow_nil: true
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :gender, presence: true, unless: -> { self.commoner? }

  scope :book_authors, -> { joins(:book_authors).order(:last_name).distinct }
  scope :iconography_authors, -> { joins(:authored_iconographies).order(:last_name).distinct }
  scope :newspaper_authors, -> { joins(:authored_newspapers).order(:last_name).distinct }

  ransack_alias :name, :first_name_or_last_name_or_name_variation
  # rubocop:enable Layout/LineLength

  def self.select_options_name
    self.pluck(:first_name, :last_name, :id).map do |person|
      ["#{person[1].upcase} #{person[0]}", person[2]]
    end
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def person_gender
    self.class.human_attribute_name("gender.#{self.gender}")
  end

  def paternal_grandfather
    self.father.try(:father)
  end

  def paternal_grandmother
    self.father.try(:mother)
  end

  def maternal_grandfather
    self.mother.try(:father)
  end

  def maternal_grandmother
    self.mother.try(:mother)
  end

  private

  def commoner?
    self.type == "Commoner"
  end

  def create_plain_text
    <<~RECORD
      #{self.first_name} #{self.last_name}
      #{self.name_variation}
      #{self.birth_place}
      #{self.death_place}
      #{self.academic_formation}
      #{self.religion&.name}
      #{self.spouse&.name}
      #{self.mother&.name}
      #{self.father&.name}
      #{self.other_family_members.to_plain_text}
      #{self.professional_activities.to_plain_text}
      #{self.description.to_plain_text}
      #{self.observation.to_plain_text}
    RECORD
  end
end
