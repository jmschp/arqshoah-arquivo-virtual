# frozen_string_literal: true

module ActiveAdmin
  module ViewsHelper
    include GetRegistrationName

    def registration(record)
      if record.persisted?
        record.registration
      elsif record.class.maximum(:id).present?
        "#{get_registration_name(record)}/#{record.class.maximum(:id).next}"
      else
        "#{get_registration_name(record)}/1"
      end
    end
  end
end
