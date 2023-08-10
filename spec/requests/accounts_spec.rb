require "rails_helper"

RSpec.describe "Accounts", type: :request do
  describe "POST /accounts" do
    it "success" do
      post "/accounts",
           params: {
             name: "jianhua",
             amount: 100,
           }.to_json, headers: basic_headers
      expect(response.status).to eq(201)
      expect(response.body).to include_json({
        name: "jianhua",
        amount: "100.0",
        frozen_amount: "0.0",
      })
    end
  end

  describe "GET /accounts/:id" do
    it "exist account" do
      account = create(:account)
      get "/accounts/#{account.id}", headers: basic_headers
      expect(response.status).to eq(200)
      expect(response.body).to include_json({
        name: account.name,
        amount: account.amount.to_s,
        frozen_amount: "0.0",
      })
    end

    it "no exist account" do
      get "/accounts/999", headers: basic_headers
      expect(response.status).to eq(404)
    end
  end

  describe "GET /accounts/:id/borrow_statistics" do
    before(:each) do
      Timecop.travel(Date.today.at_beginning_of_month)
      @account = create(:account, amount: 1000)
      @book_1 = create(:book)
      @book_2 = create(:book)
      # last month borrow tran
      Timecop.travel(Date.today - 7.days) do
        @transaction_1 = build_transaction(@book_1, @account)
      end
      # last year borrow tran
      Timecop.travel(Date.today.at_beginning_of_year - 7.days) do
        @transaction_2 = build_transaction(@book_2, @account)
      end

      @transaction_3 = build_transaction(@book_2, @account)
      # no due borrow tran
      @transaction_4 = create_transaction(@book_1, @account)
    end

    it "get monthly statistics" do
      get "/accounts/#{@account.id}/borrow_statistics",
        params: {
          type: "monthly",
          includes: ["Transaction", "Book"],
        }, headers: basic_headers
      expect(response.status).to eq(200)
      expect(response.body).to include_json({
        total_cost: @book_2.price.to_s,
        books_count: 1,
        transaction_count: 1,
        transactions: [{
          id: @transaction_3.id,
        }],
        books: [{
          id: @book_2.id,
        }],
      })
    end

    it "get yearly statistics" do
      get "/accounts/#{@account.id}/borrow_statistics",
        params: {
          type: "yearly",
          includes: ["Transaction", "Book"],
        }, headers: basic_headers
      expect(response.status).to eq(200)
      expect(response.body).to include_json({
        total_cost: (@book_2.price + @book_1.price).to_s,
        books_count: 2,
        transaction_count: 2,
        transactions: [{id: @transaction_1.id}, {id: @transaction_3.id}],
        books: [{id: @book_1.id}, {id: @book_2.id}],
      })
    end
  end
end
