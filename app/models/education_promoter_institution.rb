# frozen_string_literal: true

class EducationPromoterInstitution < ApplicationRecord
  belongs_to :education, inverse_of: :education_promoter_institutions
  belongs_to :promoter_institution, class_name: "Organization", inverse_of: :education_promoter_institutions
end
