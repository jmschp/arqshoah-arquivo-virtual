# frozen_string_literal: true

class Survivor < Person
  has_paper_trail skip: [:document_ts_vector], on: %i[create destroy update]

  # rubocop:disable Layout/LineLength
  scope :mother_siblings, ->(survivor_id, mother_id) { self.superclass.where(mother_id: mother_id).where.not(id: survivor_id) }
  scope :father_siblings, ->(survivor_id, father_id) { self.superclass.where(father_id: father_id).where.not(id: survivor_id) }
  scope :siblings, ->(survivor_id, mother_id, father_id) { self.mother_siblings(survivor_id, mother_id).or(self.father_siblings(survivor_id, father_id)) }
  # rubocop:enable Layout/LineLength
end
