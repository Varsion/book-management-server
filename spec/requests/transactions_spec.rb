require "rails_helper"

RSpec.describe "Transactions", type: :request do
  before(:each) do
    @account = create(:account, amount: 1000)
    @book = create(:book, price: 10)
    @book_idle = create(:book, price: 10)
    @book_borrowing = create(:book, price: 10, status: :borrowing)
    @book_expensive = create(:book, price: 1001)
  end

  describe "POST /transactions" do
    it "success" do
      post "/transactions",
        params: {
          account_id: @account.id,
          book_id: @book_idle.id,
          includes: ["Book", "Account"],
        }.to_json, headers: basic_headers
      expect(response.status).to eq(201)
      transaction = Transaction.find_by(id: JSON.parse(response.body)["id"])
      expect(transaction.present?).to be(true)
      expect(transaction.account).to eq(@account)
    end

    it "failed, insufficient balance" do
      post "/transactions",
        params: {
          account_id: @account.id,
          book_id: @book_expensive.id,
        }.to_json, headers: basic_headers
      expect(response.status).to eq(400)
      expect(response.body).to include_json({
        message: "Insufficient account amount",
      })
    end

    it "failed, book occupied" do
      post "/transactions",
        params: {
          account_id: @account.id,
          book_id: @book_borrowing.id,
        }.to_json, headers: basic_headers
      expect(response.status).to eq(400)
      expect(response.body).to include_json({
        message: "Book is occupied",
      })
    end
  end

  describe "GET /transactions/:id" do
    before(:each) do
      @transaction = create(:transaction, account: @account, book: @book)
    end

    it "get nonexistent transaction" do
      get "/transactions/999", headers: basic_headers
      expect(response.status).to eq(404)
    end

    it "get nonexistent transaction" do
      get "/transactions/#{@transaction.id}", headers: basic_headers
      expect(response.status).to eq(200)
    end
  end

  describe "POST /transactions/due" do
    before(:each) do
      @account.update(
        amount: @account.amount - @book.price,
        frozen_amount: @account.frozen_amount + @book.price,
      )
      @book.update(status: :borrowing)
      @transaction = create(:transaction, account: @account, book: @book)
    end

    it "not found transaction" do
      post "/transactions/due",
        params: {
          account_id: @account.id,
          book_id: @book_idle.id,
        }.to_json, headers: basic_headers
      expect(response.status).to eq(404)
    end

    it "due success" do
      post "/transactions/due",
        params: {
          account_id: @account.id,
          book_id: @book.id,
        }.to_json, headers: basic_headers
      expect(response.status).to eq(200)
      expect(response.body).to include_json({
        id: @transaction.id,
        status: "returned",
      })
      @account.reload
      expect(@account.amount).to eq(0.99e3)
      expect(@account.frozen_amount).to eq(0.0)
    end
  end
end
