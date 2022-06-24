# frozen_string_literal: true

class EducationSupporter < ApplicationRecord
  belongs_to :education, inverse_of: :education_supporters
  belongs_to :donor, polymorphic: true, inverse_of: :education_supporters
end
