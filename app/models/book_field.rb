# frozen_string_literal: true

class BookField < ApplicationRecord
  has_many :books, inverse_of: :book_field, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
