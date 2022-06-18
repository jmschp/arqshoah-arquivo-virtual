# frozen_string_literal: true

class Person < ApplicationRecord
  include DateDisplay
  include FullTextSearch
  include Registration

  # rubocop:disable Metrics/LineLength
  belongs_to :father, class_name: "Person", optional: true
  belongs_to :mother, class_name: "Person", optional: true
  belongs_to :spouse, class_name: "Person", optional: true
  belongs_to :religion, optional: true

  has_many :citations, inverse_of: :person, dependent: :destroy
  has_many :archive_citation, through: :citations, source: :record, source_type: "Archive"
  has_many :donated_archives, as: :donor, class_name: "Archive", inverse_of: :donor, dependent: :restrict_with_error
  has_many :interviews_given, class_name: "Interview", foreign_key: "interviewed_id", inverse_of: :interviewed, dependent: :destroy
  has_many :interviews_made,  class_name: "Interview", foreign_key: "interviewer_id", inverse_of: :interviewer, dependent: :destroy
  # rubocop:enable Metrics/LineLength

  has_one_attached :pdf
  has_many_attached :images

  has_rich_text :family_members
  has_rich_text :professional_activities
  has_rich_text :description
  has_rich_text :observation

  enum :gender, male: 0, female: 1

  accepts_nested_attributes_for :interviews_given, allow_destroy: true, reject_if: :all_blank

  ransack_alias :name, :first_name_or_last_name_or_name_variation

  def self.select_options_name
    self.order(:last_name).pluck(:first_name, :last_name, :id).map do |person|
      ["#{person[1].upcase} #{person[0]}", person[2]]
    end
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end

  private

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
      #{self.family_members.to_plain_text}
      #{self.professional_activities.to_plain_text}
      #{self.description.to_plain_text}
      #{self.observation.to_plain_text}
    RECORD
  end
end
