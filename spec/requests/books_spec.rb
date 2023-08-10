require "rails_helper"

RSpec.describe "Books", type: :request do
  before(:each) do
    @book = create(:book)
  end

  describe "GET /books/:id" do
    it "exist book" do
      get "/books/#{@book.id}", headers: basic_headers
      expect(response.status).to eq(200)
      expect(response.body).to include_json({
        title: @book.title,
        author: @book.author,
        price: @book.price.to_s,
      })
    end

    it "no exist book" do
      get "/books/999", headers: basic_headers
      expect(response.status).to eq(404)
    end
  end

  describe "GET /books" do
    it "success" do
      get "/books", headers: basic_headers
      result = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(result.size).to eq(1)
      expect(result[0]["id"]).to eq(@book.id)
    end
  end

  describe "GET /books/:id/actual_income" do
    before(:each) do
      @account = create(:account, amount: 1000)
      Timecop.travel(Time.current - 7.days) do
        @transaction_1 = build_transaction(@book, @account)
      end
      Timecop.travel(Time.current - 3.days) do
        @transaction_2 = build_transaction(@book, @account)
      end
      # no due
      @transaction_3 = create_transaction(@book, @account)
    end

    it "get income without date filter" do
      get "/books/#{@book.id}/actual_income", headers: basic_headers
      expect(response.status).to eq(200)
      expect(response.body).to include_json({
        income: (@book.price * 2).to_s,
      })
    end

    it "get income without date filter, with transactions" do
      get "/books/#{@book.id}/actual_income",
        params: {
          includes: ["Transaction"],
        }, headers: basic_headers

      expect(response.status).to eq(200)
      result = JSON.parse(response.body)
      expect(result["transactions"].pluck("id")).to match_array([@transaction_1.id, @transaction_2.id])
    end

    it "get income with date filter" do
      get "/books/#{@book.id}/actual_income",
        params: {
          start_time: Time.current - 10.days,
          end_time: Time.current - 5.days,
          includes: ["Transaction"],
        }, headers: basic_headers
      expect(response.status).to eq(200)
      result = JSON.parse(response.body)
      expect(result["income"]).to eq((@book.price * 1).to_s)
      expect(result["transactions"].pluck("id")).to eq([@transaction_1.id])
    end
  end
end
