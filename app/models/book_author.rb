# frozen_string_literal: true

class BookAuthor < ApplicationRecord
  belongs_to :book, inverse_of: :book_authors
  belongs_to :author, class_name: "Person", inverse_of: :book_authors
end
