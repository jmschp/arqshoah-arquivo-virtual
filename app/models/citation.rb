# frozen_string_literal: true

class Citation < ApplicationRecord
  belongs_to :record, polymorphic: true
  belongs_to :person
end
