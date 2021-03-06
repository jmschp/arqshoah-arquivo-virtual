# frozen_string_literal: true

class ArchivesController < ApplicationController
  def index
    @q = Archive.ransack(params[:q])
    @archives = @q.result(distinct: true).includes(:archive_classification, :archive_type)
                  .with_attached_images.page(params[:page])
  end

  def show
    @archive = Archive.with_attached_images.with_attached_pdf
                      .find(params[:id])
  end
end
