class TransactionsController < ApplicationController
  def create
    # if pay by the day, need required expect_return_date
    account = Account.find(params[:account_id])
    book = Book.find(params[:book_id])

    unless account.amount >= book.price
      # maybe need split render_error method
      render json: {
        message: "Insufficient account amount",
      }, status: 400
      return
    end

    unless book.status == "idle"
      render json: {
        message: "Book is occupied",
      }, status: 400
      return
    end

    ActiveRecord::Base.transaction do
      account.update(
        amount: account.amount - book.price,
        frozen_amount: account.frozen_amount + book.price,
      )
      book.update(status: :borrowing)
      @transaction = Transaction.create(
        account_id: account.id,
        book_id: book.id,
        cost: book.price,
      )
    end

    render "show", status: 201
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  # borrowing return
  def due
    @transaction = Transaction.where(
      account_id: params[:account_id],
      book_id: params[:book_id],
      status: :borrowing,
    ).last

    unless @transaction.present?
      handle_404 and return
    end

    ActiveRecord::Base.transaction do
      @transaction.account.update(
        frozen_amount: @transaction.account.frozen_amount - @transaction.cost,
      )
      @transaction.book.update(status: :idle)
      @transaction.update(
        status: :returned,
        return_date: Time.current,
      )
    end
    render "show", status: 200
  end

  private
end
