FactoryBot.define do
  factory :transaction do
    account
    book
    cost { book.price }
  end
end
