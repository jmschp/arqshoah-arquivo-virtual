# frozen_string_literal: true

class ArchiveType < ApplicationRecord
  has_many :archives, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
end
