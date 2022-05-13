# frozen_string_literal: true

module PeopleCitations
  extend ActiveSupport::Concern

  included do
    has_many :citations, as: :record, inverse_of: :record, dependent: :destroy
    has_many :people_cited, through: :citations, source: :person

    def survivors_citations
      self.people_cited.where(type: "Survivor")
    end

    def savior_citations
      self.people_cited.where(type: "Savior")
    end

    def commoners_citations
      self.people_cited.where(type: "Commoner")
    end
  end
end
