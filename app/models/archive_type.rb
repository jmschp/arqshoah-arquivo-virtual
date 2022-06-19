# frozen_string_literal: true

class ArchiveType < ApplicationRecord
  has_many :archives, inverse_of: :archive_type, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
