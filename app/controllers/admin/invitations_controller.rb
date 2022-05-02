# frozen_string_literal: true

module Admin
  class InvitationsController < Devise::InvitationsController
    layout "active_admin_logged_out"
    helper ActiveAdmin::ViewHelpers
  end
end
