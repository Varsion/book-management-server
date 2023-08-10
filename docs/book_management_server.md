# Project: Book Management Server
# 📁 Collection: Accounts 


## End-point: Create Account
### Method: POST
>```
>{{SERVER_HOST}}/accounts
>```
### Body (**json**)

```json
{
    "name": "jianhua",
    "amount": 1000
}
```

## End-point: Get Account
### Method: GET
>```
>{{SERVER_HOST}}/accounts/:id
>```

## End-point: Get Borrow Statistics
### Method: GET
>```
>{{SERVER_HOST}}/accounts/:account_id/borrow_statistics?type=monthly
>```
### Query Params

|Param|value|Description|
|:-:|:-:|:--|
|type|monthly|monthly / yearly, default is yearly|
|includes[]|Book|no required, if you wanna return book infos|
|includes[]|Transaction|no required, if you wanna return transaction infos|

---

# 📁 Collection: Books 


## End-point: Get All Books
### Method: GET
>```
>{{SERVER_HOST}}/books
>```

## End-point: Get Book
### Method: GET
>```
>{{SERVER_HOST}}/books/:id
>```

## End-point: Get Book's Actual Income
### Method: GET
>```
>{{SERVER_HOST}}/books/:id/actual_income?start_time="2023-08-01 10:37:08 UTC"&end_time="2023-08-15 10:37:08 UTC"
>```
### Query Params

|Param|value|Description|
|:-:|:--|:--|
|start_time|"2023-08-01 10:37:08 UTC"||
|end_time|"2023-08-15 10:37:08 UTC"||
|includes[]|Transaction|no required, if you wanna return transaction infos|

---

# 📁 Collection: Transactions 


## End-point: Create Transaction
### Method: POST
>```
>{{SERVER_HOST}}/transactions
>```
### Body (**raw**)

```json
{
    "account_id": 3,
    "book_id": 1,
    "includes": [
        "Account",
        "Book"
    ]
}
```

## End-point: Get Transaction Info
### Method: GET
>```
>{{SERVER_HOST}}/transactions/:id
>```
### Query Params

|Param|value|Description|
|---|---|---|
|includes[]|Account|no required, if you wanna return account infos|
|includes[]|Book|no required, if you wanna return book infos|

## End-point: Due Transaction(Return Borrowing)
### Method: POST
>```
>{{SERVER_HOST}}/transactions/due
>```
### Body (**raw**)

```json
{
    "account_id": 3,
    "book_id": 1,
    "includes": [
        "Account",
        "Book"
    ]
}
```

_________________________________________________
Powered By: [postman-to-markdown](https://github.com/bautistaj/postman-to-markdown/)
