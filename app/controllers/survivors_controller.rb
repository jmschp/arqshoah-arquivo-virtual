# frozen_string_literal: true

class SurvivorsController < ApplicationController
  def index
    @q = Survivor.ransack(params[:q])
    @survivors = @q.result(distinct: true).with_attached_images.page(params[:page])
  end

  def show; end
end
