if @account.present?
  json.partial! partial: "account", account: @account
else
  nil
end
