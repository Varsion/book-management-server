json.extract! transaction, :id, :cost, :status, :return_date

if @includes.include?("Book")
  json.book transaction.book, partial: "books/book", as: :book
end

if @includes.include?("Account")
  json.account transaction.account, partial: "accounts/account", as: :account
end
