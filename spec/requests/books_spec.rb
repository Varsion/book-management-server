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
end
