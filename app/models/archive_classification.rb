# frozen_string_literal: true

class ArchiveClassification < ApplicationRecord
  has_many :archives, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
end
