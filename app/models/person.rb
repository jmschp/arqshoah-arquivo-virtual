# frozen_string_literal: true

class Person < ApplicationRecord
  belongs_to :religion, optional: true

  has_many :citations, inverse_of: :person, dependent: :destroy
  has_many :archive_citation, through: :citations, source: :record, source_type: "Archive"

  has_many :donated_archives, as: :donor, class_name: "Archive", inverse_of: :donor, dependent: :restrict_with_error
  has_many :interviews_given, foreign_key: "interviewed_id", inverse_of: :interviewed, dependent: :destroy
  has_many :interviews_made, foreign_key: "interviewer_id", inverse_of: :interviewer, dependent: :destroy

  has_one_attached :pdf
  has_many_attached :images
end
