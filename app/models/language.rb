# frozen_string_literal: true

class Language < ApplicationRecord
  has_many :archives, inverse_of: :language, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
end
