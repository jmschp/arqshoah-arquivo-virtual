# frozen_string_literal: true

class NewspaperType < ApplicationRecord
  has_many :newspapers, inverse_of: :newspaper_type, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
