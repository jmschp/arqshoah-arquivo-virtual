# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_paper_trail_whodunnit

  protected

  def configure_permitted_parameters
    # Additional attributes for inviting users and accept invitation forms
    devise_parameter_sanitizer.permit(:invite, keys: %i[name email_confirmation])
  end

  def user_for_paper_trail
    "ID: #{current_admin_user.id} - EMAIL: #{current_admin_user.email}" if admin_user_signed_in?
  end
end
