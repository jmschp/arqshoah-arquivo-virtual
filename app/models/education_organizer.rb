# frozen_string_literal: true

class EducationOrganizer < ApplicationRecord
  belongs_to :education, inverse_of: :education_organizers
  belongs_to :organizer, class_name: "Person", inverse_of: :education_organizers
end
