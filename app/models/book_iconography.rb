# frozen_string_literal: true

class BookIconography < ApplicationRecord
  belongs_to :book, inverse_of: :book_iconographies
  belongs_to :iconography, inverse_of: :book_iconographies
end
