# frozen_string_literal: true

class SaviorsController < ApplicationController
  def index
    @q = Savior.ransack(params[:q])
    @saviors = @q.result(distinct: true).with_attached_images.page(params[:page])
  end

  def show
    @savior = Savior.includes(:religion).with_attached_images
                    .with_rich_text_description
                    .with_rich_text_observation
                    .with_rich_text_professional_activities
                    .find(params[:id])
  end
end
