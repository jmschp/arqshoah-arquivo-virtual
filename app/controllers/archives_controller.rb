# frozen_string_literal: true

class ArchivesController < ApplicationController
  def index
    @q = Archive.ransack(params[:q])
    @archives = @q.result(distinct: true).includes(:archive_classification, :archive_type)
                  .with_attached_images.page(params[:page])
  end

  def show
    @archive = Archive.includes(
      :archive_classification, :archive_type, :language, :donor, :people_cited,
      :issuing_agency, :receiver_agency
    ).with_attached_images.with_rich_text_description.with_rich_text_observation.find(params[:id])
  end
end
