# frozen_string_literal: true

class Language < ApplicationRecord
  has_many :archives, inverse_of: :language, dependent: :restrict_with_error
  has_many :books, inverse_of: :language, dependent: :restrict_with_error
  has_many :newspapers, inverse_of: :language, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }

  scope :book_language, -> { joins(:books).order(:name).distinct }
end
