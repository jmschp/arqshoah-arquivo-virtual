# frozen_string_literal: true

class IconographiesController < ApplicationController
  def index
    @q = Iconography.ransack(params[:q])
    @iconographies = @q.result(distinct: true).includes(:iconography_technic, :iconography_type)
                       .with_attached_image.page(params[:page])
  end

  def show
    @iconography = Iconography.includes(
      :author, :donor, :iconography_support, :iconography_technic, :iconography_type
    ).with_attached_image.with_rich_text_description.with_rich_text_observation.find(params[:id])
  end
end
