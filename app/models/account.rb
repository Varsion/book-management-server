class Account < ApplicationRecord
  has_many :transactions

  has_many :due_transactions, -> { where(status: :returned) }, class_name: "Transaction", foreign_key: :account_id

  validate :check_amount

  def check_amount
    if amount < 0 || frozen_amount < 0
      errors.add(:amount, "Calculation or Service error")
    end
  end
end
