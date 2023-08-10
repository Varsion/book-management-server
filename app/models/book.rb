class Book < ApplicationRecord
  enum status: {
    idle: 0,
    borrowing: 1,
  }

  has_many :transactions

  has_many :due_transactions, -> { where(status: :returned) }, class_name: "Transaction", foreign_key: :book_id
end
