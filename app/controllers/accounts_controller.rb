class AccountsController < ApplicationController
  def create
    @account = Account.create(create_params)
    # no any data validation now
    render "show", status: 201
  end

  def show
    @account = Account.find_by(id: params[:id])
  end

  private

  def create_params
    params.permit(:name, :amount)
  end
end