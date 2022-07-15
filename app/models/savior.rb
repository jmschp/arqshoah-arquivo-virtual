# frozen_string_literal: true

class Savior < Person
  DETAIL_ATTRIBUTES = [
    { type: :direct, attribute: :registration },
    { type: :direct, attribute: :name },
    { type: :direct, attribute: :person_gender },
    { type: :date_display, attribute: :birth_date },
    { type: :direct, attribute: :birth_place_city },
    { type: :direct, attribute: :birth_place_state },
    { type: :direct, attribute: :birth_place_country },
    { type: :date_display, attribute: :death_date },
    { type: :direct, attribute: :birth_place_city },
    { type: :direct, attribute: :birth_place_state },
    { type: :direct, attribute: :birth_place_country },
    { type: :associated, attribute: :religion }
  ].freeze

  has_paper_trail skip: [:document_ts_vector], on: %i[create destroy update]
end
