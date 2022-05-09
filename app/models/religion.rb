# frozen_string_literal: true

class Religion < ApplicationRecord
  has_many :people, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
end
