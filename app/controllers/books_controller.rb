# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    @q = Book.ransack(params[:q])
    @books = @q.result(distinct: true).includes(:book_category, :book_field).with_attached_image.page(params[:page])
  end

  def show
    @book = Book.includes(
      :book_category, :book_field, :publishing_company, :language, :people_cited, :iconographies, :authors
    ).with_attached_image.with_rich_text_description.with_rich_text_observation.find(params[:id])
  end
end
