class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :book

  enum status: {
    borrowing: 0,
    returned: 1,
  }
end
