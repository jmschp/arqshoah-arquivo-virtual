# frozen_string_literal: true

class Interview < ApplicationRecord
  belongs_to :interviewed, class_name: "Person", inverse_of: :interviews_given
  belongs_to :interviewer, class_name: "Person", inverse_of: :interviews_made

  validates :date, presence: true
  validates :location, presence: true
end
