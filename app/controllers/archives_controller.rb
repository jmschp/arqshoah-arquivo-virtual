# frozen_string_literal: true

class ArchivesController < ApplicationController
  def index
    @archives = Archive.includes(:archive_classification, :archive_type).with_attached_images
  end

  def show; end
end
