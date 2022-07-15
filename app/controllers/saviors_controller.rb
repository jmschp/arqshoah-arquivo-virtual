# frozen_string_literal: true

class SaviorsController < ApplicationController
  def index
    @q = Savior.ransack(params[:q])
    @saviors = @q.result(distinct: true).with_attached_images.page(params[:page])
  end

  def show; end
end
