class Book < ApplicationRecord
  enum status: {
    idle: 0,
    borrowing: 1
  }
end
