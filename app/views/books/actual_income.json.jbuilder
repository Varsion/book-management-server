json.income @income

if @includes.include?("Transaction")
  json.transactions @transactions, partial: "transactions/transaction", as: :transaction
end
