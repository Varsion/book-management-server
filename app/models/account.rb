class Account < ApplicationRecord
  has_many :transactions

  has_many :due_transactions, -> { where(status: :returned) }, class_name: "Transaction", foreign_key: :account_id
end
