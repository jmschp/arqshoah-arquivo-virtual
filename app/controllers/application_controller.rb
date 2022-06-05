# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # Additional attributes for inviting users and accept invitation forms
    devise_parameter_sanitizer.permit(:invite, keys: %i[name email_confirmation])
  end
end
