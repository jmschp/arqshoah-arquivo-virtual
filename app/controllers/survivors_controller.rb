# frozen_string_literal: true

class SurvivorsController < ApplicationController
  def index
    @q = Survivor.ransack(params[:q])
    @survivors = @q.result(distinct: true).with_attached_images.page(params[:page])
  end

  def show
    @survivor = Survivor.includes(:religion).with_attached_images.with_rich_text_description.with_rich_text_observation
                        .with_rich_text_professional_activities.find(params[:id])

    @siblings = Survivor.siblings(@survivor.id, @survivor.mother&.id, @survivor.father&.id)
  end
end
