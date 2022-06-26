# frozen_string_literal: true

class ArchivesController < ApplicationController
  def index
    @archives = Archive.all
  end

  def show; end
end
