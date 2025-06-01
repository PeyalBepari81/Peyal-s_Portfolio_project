# 📚 Book Order Analysis Project

This project performs data analysis on a bookstore's inventory, customer base, and order history to uncover insights into book sales, genres, customer behavior, and revenue.

## 📁 Project Structure

- `BOOK_ORDER_ANLYSIS.sql` – SQL script with queries for both basic and advanced analysis.
- `Basic Queries.docx` – Documentation of query use-cases and results.
- `Books.csv` – Book catalog including price, stock, genre, and author.
- `Customers.csv` – Customer information including location and contact details.
- `Orders.csv` – Purchase history of customers including quantity and date.
- `README.md` – Project overview and instructions.

---

## 📊 Dataset Overview

### 🔸 Books.csv
| Column Name | Description                        |
|-------------|------------------------------------|
| BookID      | Unique identifier for each book    |
| Title       | Title of the book                  |
| Author      | Author of the book                 |
| Genre       | Genre/category of the book         |
| Price       | Selling price of the book          |
| Stock       | Number of books currently in stock |
| PublishYear | Year the book was published        |

### 🔸 Customers.csv
| Column Name | Description                         |
|-------------|-------------------------------------|
| CustomerID  | Unique identifier for each customer |
| Name        | Name of the customer                |
| Country     | Country of the customer             |
| City        | City of the customer                |

### 🔸 Orders.csv
| Column Name | Description                         |
|-------------|-------------------------------------|
| OrderID     | Unique order identifier             |
| CustomerID  | ID of the customer placing the order|
| BookID      | ID of the book ordered              |
| Quantity    | Number of units ordered             |
| OrderDate   | Date of the order                   |

---

## ✅ Queries Implemented

### 🔹 Basic Queries
1. Retrieve all books in the "Fiction" genre  
2. Find books published after the year 1950  
3. List all customers from Canada  
4. Show orders placed in November 2023  
5. Retrieve the total stock of books available  
6. Find the details of the most expensive book  
7. Show all customers who ordered more than 1 quantity of a book  
8. Retrieve all orders where the total amount exceeds $20  
9. List all genres available in the Books table  
10. Find the book with the lowest stock  
11. Calculate the total revenue generated from all orders  

### 🔹 Advanced Queries
1. Retrieve the total number of books sold for each genre  
2. Find the average price of books in the "Fantasy" genre  
3. List customers who have placed at least 2 orders  
4. Find the most frequently ordered book  
5. Show the top 3 most expensive books of the "Fantasy" genre  
6. Retrieve the total quantity of books sold by each author  
7. List the cities where customers who spent over $30 are located  
8. Find the customer who spent the most on orders  
9. Calculate the stock remaining after fulfilling all orders  

---

## 🛠️ Technologies Used

- **SQL** – For querying and analyzing data  
