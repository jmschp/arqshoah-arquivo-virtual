# frozen_string_literal: true

module Registration
  extend ActiveSupport::Concern
  include GetRegistrationName

  included do
    after_create :set_registration
  end

  private

  def set_registration
    registration_name = get_registration_name(self)

    self.update_column(:registration, "#{registration_name}/#{self.id}") # rubocop:disable Rails/SkipsModelValidations
  end
end
