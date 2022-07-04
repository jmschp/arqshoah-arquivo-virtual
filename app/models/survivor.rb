# frozen_string_literal: true

class Survivor < Person
  DETAIL_ATTRIBUTES = [
    { type: :direct, attribute: :registration },
    { type: :direct, attribute: :name },
    { type: :direct, attribute: :name_variation },
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

  # rubocop:disable Layout/LineLength
  scope :mother_siblings, ->(survivor_id, mother_id) { self.superclass.where(mother_id: mother_id).where.not(id: survivor_id) }
  scope :father_siblings, ->(survivor_id, father_id) { self.superclass.where(father_id: father_id).where.not(id: survivor_id) }
  scope :siblings, ->(survivor_id, mother_id, father_id) { self.mother_siblings(survivor_id, mother_id).or(self.father_siblings(survivor_id, father_id)) }
  # rubocop:enable Layout/LineLength

  has_paper_trail skip: [:document_ts_vector], on: %i[create destroy update]
end
