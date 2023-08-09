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
      result = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(result.blank?).to be(true)
    end
  end
end
