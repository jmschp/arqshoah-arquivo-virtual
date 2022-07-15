# frozen_string_literal: true

class EducationsController < ApplicationController
  def index
    @q = Education.ransack(params[:q])
    @educations = @q.result(distinct: true).includes(:education_category, :venue)
                    .with_attached_images.page(params[:page])
  end

  def show
    @education = Education.with_attached_images.with_attached_pdf
                          .find(params[:id])
  end
end
