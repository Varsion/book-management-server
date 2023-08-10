class BooksController < ApplicationController
  def index
    @books = Book.all

    if params[:status].present?
      @books = @books.where(status: params[:status])
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def actual_income
    @book = Book.find(params[:id])
    @includes = Array.wrap(params[:includes]) || []
    @transactions = @book.due_transactions

    if params[:start_time].present?
      @transactions = @transactions.where("created_at > ? ", DateTime.parse(params[:start_time]))
    end

    if params[:end_time].present?
      @transactions = @transactions.where("return_date < ?", DateTime.parse(params[:end_time]))
    end

    @income = @transactions.sum(:cost)
  end

  # maybe need search book
  # Book.where("title LIKE %#{params[:key]}%")
end
