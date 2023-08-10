json.total_cost @total_cost
json.books_count @books_count
json.transaction_count @transaction_count

if @includes.include?("Transaction")
  json.transactions @transactions, partial: "transactions/transaction", as: :transaction
end

if @includes.include?("Book")
  json.books @books, partial: "books/book", as: :book
end
