require "rails_helper"

RSpec.describe Account, type: :model do
  describe "validation" do
    it "update amount to -10, get errors" do
      account = create(:account)
      account.update(amount: -10)
      expect(account.errors).not_to be(nil)
    end

    it "create amount to -10, get errors" do
      account = Account.create(name: "Jianhua", amount: -10)
      expect(account.errors).not_to be(nil)
    end
  end
end
