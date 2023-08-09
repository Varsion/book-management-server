if @book.present?
  json.partial! partial: "book", book: @book
else
  nil
end
