# frozen_string_literal: true

class BookCategory < ApplicationRecord
  has_many :books, inverse_of: :book_category, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
