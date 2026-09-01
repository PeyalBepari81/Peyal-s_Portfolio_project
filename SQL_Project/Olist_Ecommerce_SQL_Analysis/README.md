# Olist E-Commerce SQL Analysis

## Project Overview

This project presents an end-to-end SQL analysis of the **Brazilian E-Commerce Public Dataset by Olist** using PostgreSQL.

The analysis follows a structured workflow that covers database setup, data-quality validation, sales analysis, and advanced business analysis.

The objective is to transform transactional e-commerce data into meaningful business insights through structured SQL analysis.

---

## Dataset

**Dataset:** Brazilian E-Commerce Public Dataset by Olist

**Source:** [Kaggle - Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

The dataset contains information related to the Olist e-commerce platform, including customers, orders, order items, products, sellers, payments, reviews, and geolocation data.

The original dataset is not included in this repository.

---

## Project Structure

```text
Olist_Ecommerce_SQL_Analysis/
│
├── 01_create_tables.sql
├── 02_data_quality_checks.sql
├── 03_sales_analysis.sql
├── 04_Advanced_Business_Analysis.sql
└── README.md
```

---

## Analysis Workflow

The project is divided into four stages.

### 1. Database & Table Creation

**File:** `01_create_tables.sql`

This script establishes the relational database structure required for the Olist dataset.

It defines the tables and database relationships required for the subsequent data-quality checks and analytical queries.

The database structure is designed to support analysis across customers, orders, products, sellers, payments, reviews, and related e-commerce entities.

---

### 2. Data Quality Checks

**File:** `02_data_quality_checks.sql`

This stage validates the dataset before business analysis is performed.

The data-quality analysis examines areas such as:

- NULL and missing values
- Duplicate records
- Invalid or unexpected values
- Data consistency
- Referential integrity
- Key relationships
- Field-level validation

The purpose of this stage is to identify potential data-quality issues and understand the reliability of the source data before using it for analysis.

---

### 3. Sales Analysis

**File:** `03_sales_analysis.sql`

This stage performs descriptive and exploratory analysis of the Olist e-commerce data.

The analysis examines business areas including:

- Revenue
- Orders
- Customers
- Products
- Product categories
- Sellers
- Payment methods
- Geographic performance
- Delivery performance

The queries combine information from multiple relational tables to calculate business metrics and identify patterns in e-commerce performance.

---

### 4. Advanced Business Analysis

**File:** `04_Advanced_Business_Analysis.sql`

This stage extends the analysis to more advanced business questions.

The analysis focuses on areas such as:

- Customer purchasing behavior
- Customer value
- Repeat purchasing
- Product performance
- Category performance
- Revenue trends
- Customer ordering patterns
- Business performance over time

Advanced SQL techniques are applied to perform more complex analytical operations and generate business-oriented insights.

---

## Business Areas Analyzed

### Sales & Revenue

Analysis of revenue, sales performance, order activity, and related business metrics.

### Customer Analysis

Analysis of customer activity, purchasing behavior, order frequency, and customer value.

### Product Analysis

Analysis of product performance, product categories, and revenue contribution.

### Seller Analysis

Analysis of seller activity, seller performance, and geographic distribution.

### Payment Analysis

Analysis of payment methods and payment-related transaction patterns.

### Order Analysis

Analysis of order activity, order status, and order-related performance.

### Delivery Analysis

Analysis of delivery performance, delivery time, delays, and related operational metrics.

---

## SQL Techniques

The project demonstrates practical SQL techniques used for data analysis, including:

- Relational database design
- Table creation
- Primary and foreign keys
- Multi-table `JOIN`s
- `WHERE`
- `GROUP BY`
- `ORDER BY`
- `HAVING`
- Aggregate functions
- `CASE` statements
- Subqueries
- Common Table Expressions (CTEs)
- Window functions
- Ranking
- Date and time analysis
- Data-quality validation
- Conditional aggregation

---

## Analytical Workflow

```text
Olist Dataset
      ↓
Database & Table Creation
      ↓
Data Quality Validation
      ↓
Sales & Exploratory Analysis
      ↓
Advanced Business Analysis
      ↓
Business Insights
```

---

## Project Objective

The objective of this project is to demonstrate the practical application of SQL to a real-world e-commerce dataset.

The project covers the analytical process from database setup and data validation to exploratory and advanced business analysis.

It demonstrates the ability to work with relational data, combine information across multiple tables, perform data-quality validation, develop analytical queries, and translate transactional data into business insights.

---

## Tools & Technologies

- **PostgreSQL**
- **SQL**
- **GitHub**

---

## Author

**Peyal Bepari**

Data Analyst | Machine Learning Analyst
