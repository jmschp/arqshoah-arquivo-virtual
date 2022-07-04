# frozen_string_literal: true

class SurvivorsController < ApplicationController
  def index
    @q = Survivor.ransack(params[:q])
    @survivors = @q.result(distinct: true).with_attached_images.page(params[:page])
  end

  def show
    @survivor = Survivor.find(params[:id])
    @siblings = Survivor.siblings(@survivor.id, @survivor.mother&.id, @survivor.father&.id)
  end
end
