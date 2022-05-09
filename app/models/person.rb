# frozen_string_literal: true

class Person < ApplicationRecord
  belongs_to :religion, optional: true

  has_one_attached :pdf
  has_many_attached :images
end
