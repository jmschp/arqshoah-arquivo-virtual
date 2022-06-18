# frozen_string_literal: true

class Survivor < Person
  # rubocop:disable Metrics/LineLength
  scope :mother_siblings, ->(survivor_id, mother_id) { self.superclass.where(mother_id: mother_id).where.not(id: survivor_id) }
  scope :father_siblings, ->(survivor_id, father_id) { self.superclass.where(father_id: father_id).where.not(id: survivor_id) }
  scope :siblings, ->(survivor_id, mother_id, father_id) { self.mother_siblings(survivor_id, mother_id).or(self.father_siblings(survivor_id, father_id)) }
  # rubocop:enable Metrics/LineLength
end
