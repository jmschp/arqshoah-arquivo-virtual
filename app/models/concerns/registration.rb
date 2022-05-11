# frozen_string_literal: true

module Registration
  extend ActiveSupport::Concern

  included do
    after_create :set_registration
  end

  private

  def set_registration
    registration = case self
                   when Archive
                     "RG-ARQ/#{self.id}"
                   #  when Book
                   #  "RG-PUB/#{self.id}"
                   #  when Education
                   # "RG-EDU/#{self.id}"
                   #  when Iconography
                   #  "RG-ICO/#{self.id}"
                   #  when Patrimony
                   #  "RG-PAT/#{self.id}"
                   when Savior
                     "RG-PER/#{self.id}"
                   #  when Press
                   #  "RG-HEM/#{self.id}"
                   when Survivor
                     "RG-TES/#{self.id}"

                   end

    self.update_column(:registration, registration) # rubocop:disable  Rails/SkipsModelValidations
  end
end
