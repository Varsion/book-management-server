
# Book Management Server

![Ruby](https://img.shields.io/badge/Ruby-3.1.0-red) ![Rails](https://img.shields.io/badge/Rails-7.0-red) ![Coverage](https://img.shields.io/badge/Coverage-99%-green)

## Live Demo

Support by: [Render](https://render.com) Free Trail

https://book-management-server-8lqn.onrender.com

## Description

- There are no `User` entities, only `Account` entities.
- A `Book` can only be occupied by one `Account` at a time (rental)
- Borrowing a book is considered a `Transaction`
- `includes` is a parameter field whether to include additional information, It is **Array**, and **no required**

## API Doc

Can directly import postman's json file to view and use.

Doc: https://github.com/Varsion/book-management-server/tree/master/docs/book_management_server.md

PostMan Export File: https://github.com/Varsion/book-management-server/tree/master/docs/book_management_server.postman_collection.json

