# frozen_string_literal: true

class NewspapersController < ApplicationController
  def index
    @q = Newspaper.ransack(params[:q])
    @newspapers = @q.result(distinct: true).includes(:newspaper_type, :agency)
                    .with_attached_image.page(params[:page])
  end

  def show
    @newspaper = Newspaper.with_attached_image.with_attached_pdf
                          .find(params[:id])
  end
end
