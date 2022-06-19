# frozen_string_literal: true

class IconographySupport < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
