📚 Bookstore Data Analysis (SQL Project)


🧾 Project Overview


This project focuses on performing data analysis on a bookstore database that includes information about books, customers, and their purchase history.
Using PostgreSQL, the analysis uncovers insights related to sales performance, customer behavior, genre trends, and inventory management.

The project demonstrates practical applications of SQL for querying, cleaning, and analyzing structured data, replicating real-world data analysis scenarios.



🗂️ Project Structure


File	Description
BOOK_ORDER_ANALYSIS.sql	Main SQL script containing table creation, data import, and analytical queries (basic + advanced).
Books.csv	Dataset containing book details such as title, author, genre, price, stock, and publication year.
Customers.csv	Dataset containing customer details such as name, contact information, and location.
Orders.csv	Dataset containing purchase details, including order date, book ID, customer ID, and total amount.
Basic Queries.docx	Documentation of all query statements and outputs.
README.md	Project overview, setup guide, and key insights.


🧱 Database Schema


Books Table
Column	Type	Description
Book_ID	SERIAL	Unique identifier for each book
Title	VARCHAR(100)	Title of the book
Author	VARCHAR(100)	Author name
Genre	VARCHAR(50)	Book genre/category
Published_Year	INT	Year the book was published
Price	NUMERIC(10,2)	Selling price of the book
Stock	INT	Number of books available in stock
Customers Table
Column	Type	Description
Customer_ID	SERIAL	Unique identifier for each customer
Name	VARCHAR(100)	Customer name
Email	VARCHAR(100)	Email address
Phone	VARCHAR(15)	Contact number
City	VARCHAR(50)	City of residence
Country	VARCHAR(150)	Country of residence
Orders Table
Column	Type	Description
Order_ID	SERIAL	Unique order identifier
Customer_ID	INT	Linked to Customers(Customer_ID)
Book_ID	INT	Linked to Books(Book_ID)
Order_Date	DATE	Date of the order
Quantity	INT	Number of units ordered
Total_Amount	NUMERIC(10,2)	Total order value


⚙️ Database Setup & Data Import


-- Create Tables

DROP TABLE IF EXISTS Books;

CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);


-- Import Data


COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
FROM 'P:\RESOURCE\Books.csv' CSV HEADER;

COPY Customers(Customer_ID, Name, Email, Phone, City, Country)
FROM 'P:\RESOURCE\Customers.csv' CSV HEADER;

COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount)
FROM 'P:\RESOURCE\Orders.csv' CSV HEADER;

🧠 Queries Implemented


Basic Queries 

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
    
Advance Queries

1. Retrieve the total number of books sold for each genre 
2. Find the average price of books in the "Fantasy" genre 
3. List customers who have placed at least 2 orders 
4. Find the most frequently ordered book 
5. Show the top 3 most expensive books of 'Fantasy' genre 
6. Retrieve the total quantity of books sold by each author 
7. List the cities where customers who spent over $30 are located 
8. Find the customer who spent the most on orders 
9. Calculate the stock remaining after fulfilling all orders

    
📊 Key Insights from the Analysis


Fiction and Fantasy genres showed the highest sales volumes.

The Fantasy genre had the highest average price, contributing significantly to revenue.

November 2023 recorded the most orders, indicating possible seasonal demand.

Around 30% of customers placed multiple orders, showing moderate customer retention.

The top-spending customer spent over $120, highlighting the value of repeat buyers.

The most frequently ordered book belonged to the Fantasy genre.

After fulfilling all orders, roughly 70–75% of total inventory remained in stock, suggesting balanced stock management.



🛠️ Technologies Used



PostgreSQL – for database creation and SQL query execution

CSV Files – for structured data import

pgAdmin / DBeaver – for managing SQL scripts and data visualization



📈 Key Learnings



Designed relational schemas with proper primary and foreign key constraints

Imported and managed datasets using PostgreSQL’s COPY command

Performed aggregation, joins, and filtering for business insights

Derived actionable insights on sales, customer engagement, and inventory trends



🚀 Future Enhancements



Integrate with Python (Pandas) for automated analysis

Build interactive dashboards using Power BI or Tableau

Implement stored procedures or triggers for real-time stock updates


👨‍💻 Author


Peyal Bepari

📍 Kolkata, India

🎓 M.Tech in Control System Engineering

🔗 LinkedIn : www.linkedin.com/in/peyal-bepari-52a621181

 | GitHub Repository : https://github.com/PeyalBepari81/Peyal-s_Portfolio_project
