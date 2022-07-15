# frozen_string_literal: true

class IconographiesController < ApplicationController
  def index
    @q = Iconography.ransack(params[:q])
    @iconographies = @q.result(distinct: true).includes(:iconography_technic, :iconography_type)
                       .with_attached_image.page(params[:page])
  end

  def show
    @iconography = Iconography.with_attached_image
                              .find(params[:id])
  end
end
