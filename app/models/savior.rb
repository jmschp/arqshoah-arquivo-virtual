# frozen_string_literal: true

class Savior < Person
  has_paper_trail skip: [:document_ts_vector], on: %i[create destroy update]
end
