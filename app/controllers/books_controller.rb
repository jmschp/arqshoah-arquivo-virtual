# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    @q = Book.ransack(params[:q])
    @books = @q.result(distinct: true).includes(:book_category, :book_field).with_attached_image.page(params[:page])
  end

  def show; end
end
