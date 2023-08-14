require "rails_helper"

RSpec.describe "Index", type: :request do
  describe "GET /" do
    it "success" do
      get "/", headers: basic_headers
      expect(response.status).to eq(200)
    end
  end
end
