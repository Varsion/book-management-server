class BooksController < ApplicationController

  def index
    @books = Book.all

    if params[:status].present?
      @books = @books.where(status: params[:status])
    end
  end

  def show
    @book = Book.find_by(id: params[:id])
  end

  # maybe need search book
  # Book.where("title LIKE %#{params[:key]}%")
end
