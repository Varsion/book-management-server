class Book < ApplicationRecord
  enum status: {
    idle: 0,
    borrowing: 1,
  }

  has_many :transactions
end
