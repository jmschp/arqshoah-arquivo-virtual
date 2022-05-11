# frozen_string_literal: true

class Person < ApplicationRecord
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
end
