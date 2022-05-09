# frozen_string_literal: true

class Survivor < Person
  belongs_to :spouse, class_name: "Person", optional: true
  belongs_to :mother, class_name: "Person", optional: true
  belongs_to :father, class_name: "Person", optional: true
end
