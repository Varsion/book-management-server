class AccountsController < ApplicationController
  def create
    @account = Account.create(create_params)
    # no any data validation now
    render "show", status: 201
  end

  def show
    @account = Account.find(params[:id])
  end

  def borrow_statistics
    @account = Account.find(params[:id])
    @transactions = @account.due_transactions.includes(:book)

    # Book, Transaction
    @includes = Array.wrap(params[:includes]) || []

    if params[:type] == "monthly"
      start_time = DateTime.current.at_beginning_of_month
      end_time = DateTime.current.at_end_of_month
    else
      start_time = DateTime.current.at_beginning_of_year
      end_time = DateTime.current.at_end_of_year
    end

    @transactions = @transactions.where("transactions.created_at > :start_time AND transactions.return_date < :end_time", { start_time: start_time, end_time: end_time })

    @books = @transactions.map(&:book)
    @transaction_count = @transactions.count
    @books_count = @books.count
    @total_cost = @transactions.sum(:cost)
  end

  private

  def create_params
    params.permit(:name, :amount)
  end
end
