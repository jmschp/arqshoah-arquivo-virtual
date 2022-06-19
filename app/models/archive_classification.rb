# frozen_string_literal: true

class ArchiveClassification < ApplicationRecord
  has_many :archives, inverse_of: :archive_classification, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
