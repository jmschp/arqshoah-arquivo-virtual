# frozen_string_literal: true

class EducationsController < ApplicationController
  def index
    @q = Education.ransack(params[:q])
    @educations = @q.result(distinct: true).includes(:education_category, :venue)
                    .with_attached_images.page(params[:page])
  end

  def show; end
end
