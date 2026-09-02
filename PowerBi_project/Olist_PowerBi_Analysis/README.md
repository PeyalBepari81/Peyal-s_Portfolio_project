# Olist Power BI E-Commerce Analysis

## Project Overview

This project analyzes the Brazilian Olist E-Commerce dataset using Microsoft Power BI.

The objective is to transform raw e-commerce data into an interactive Business Intelligence dashboard that provides insights into sales performance, products, customers, payments, and delivery operations.

The project covers data preparation, data quality assessment, dimensional data modeling, DAX measures, KPI development, interactive visualizations, and business-focused analysis.

---

## Dataset

The analysis uses the **Brazilian E-Commerce Public Dataset by Olist**, which contains approximately 100,000 orders from 2016 to 2018 and includes information about customers, orders, products, sellers, payments, reviews, and geolocation.

### Raw Dataset

**[Brazilian E-Commerce Public Dataset by Olist - Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)**

The dataset was provided by Olist and published on Kaggle.

The original dataset contains anonymized commercial data.

---

## Dataset Statistics

The following datasets were used in the analysis:

| Dataset | Records |
|---|---:|
| Customers | 99,441 |
| Orders | 99,441 |
| Order Items | 112,650 |
| Products | 32,951 |
| Sellers | 3,095 |
| Order Payments | 103,886 |
| Order Reviews | 99,224 |
| Geolocation | 1,000,163 |
| Product Category Translation | 71 |

---

## Data Preparation & Quality Assessment

Before developing the Power BI dashboard, the source data was assessed for quality, completeness, consistency, and relationship integrity.

The data-quality assessment included:

- NULL value analysis
- Duplicate record checks
- Duplicate identifier checks
- Blank value checks
- Referential integrity checks
- Invalid numeric value checks
- Invalid coordinate checks
- Category matching checks
- Identifier consistency checks
- Data-type validation
- Review-score validation

### Key Data Quality Findings

#### Customers

- 99,441 records
- No duplicate `customer_id`
- No NULL values in mandatory fields
- `customer_unique_id` duplicates are expected because the same actual customer can have multiple order-specific `customer_id` values

#### Orders

- 99,441 records
- Delivery-related NULL values were identified and retained because they can represent legitimate order-status situations
- Customer relationships were maintained through `customer_id`

#### Products

- 32,951 records
- 610 NULL values were identified in several product attributes
- 2 NULL values were identified for product weight, length, height, and width fields
- 4 products had a product weight of 0
- 13 product categories were not matched with the English translation table
- Raw product data was retained for further investigation

#### Sellers

- 3,095 records
- One anomalous numeric-only seller city value was identified
- The original value was retained rather than arbitrarily modifying the source data

#### Order Items

- 112,650 records
- No NULL values in required fields
- No duplicate composite primary keys
- No negative price or freight values
- Referential integrity maintained

#### Order Payments

- 103,886 records
- No NULL values in required fields
- Composite order/payment key was unique
- Payment installments ranged from 0 to 24
- No negative payment values
- Multiple payment records can exist for a single order

#### Order Reviews

- 99,224 records
- No NULL values in mandatory fields
- Review comments are optional and therefore contain NULL values
- Duplicate `review_id` values were identified
- Review scores were within the expected 1–5 range

#### Geolocation

- 1,000,163 records
- Duplicate ZIP-prefix records are expected
- No invalid geographic coordinates were identified
- No NULL city or state values
- Geographic records were retained because multiple observations can exist for the same ZIP prefix

---

## Tools & Technologies

- Microsoft Power BI
- Power Query
- DAX
- Data Modeling
- Dimensional Modeling
- Data Visualization
- Business Intelligence
- SQL
- PostgreSQL

---

## Power BI Data Model

The Power BI model uses a dimensional modeling approach.

### Main Dimensions

- `DimCustomer`
- `DimProduct`
- `DimSeller`
- `DimDate`

The product category translation data was incorporated into `DimProduct` to provide English product category names.

The model was designed to support interactive analysis across:

- Customers
- Products
- Sellers
- Dates
- Orders
- Order Items
- Payments
- Reviews
- Delivery information

### Customer Modeling

The Olist dataset contains two important customer identifiers:

- `customer_id` — identifies an order-specific customer record
- `customer_unique_id` — identifies the actual customer across multiple orders

For repeat-customer analysis, `customer_unique_id` was used because it represents the actual customer and allows repeat purchasing behavior to be identified correctly.

---

## Dashboard Pages

The Power BI report contains four main analytical pages.

### Executive Overview
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/eb06a0e1-f0b5-4ca4-8d95-6722a8675a17" />
### Sales & Product Analysis
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/8212fe8e-7597-4367-bc70-8d06f00aee49" />
### Customer Analysis
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/a0b25158-41ca-46a0-832d-ac6bbaf6dc2a" />
### Logistics & Delivery Analysis
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/1e1edda7-cb81-4036-9d8b-c47136852585" />


---

## 1. Executive Overview

The Executive Overview provides a high-level view of overall e-commerce performance.

### Key Metrics

- Total Sales
- Total Orders
- Total Items
- Total Customers
- Average Order Value
- Total Freight
- Revenue
- Sales trends

### Analysis Areas

- Sales performance over time
- Customer distribution
- Order status
- Geographic sales distribution
- Overall business KPIs

---

## 2. Sales & Product Analysis

This page focuses on sales performance and product-level analysis.

### Analysis Areas

- Sales trends
- Product categories
- Product performance
- Sales by customer state
- Payment types
- Revenue performance
- Category-level sales
- Order and item performance

This page helps identify the products and categories contributing to overall business performance.

---

## 3. Customer Analysis

This page focuses on customer behavior and purchasing patterns.

### Analysis Areas

- Total customers
- Customer distribution
- Orders per customer
- Repeat customers
- Customer purchasing behavior
- Customer geographic distribution
- Customer order frequency

The customer-order distribution analysis helps identify differences between one-time and repeat purchasing behavior.

---

## 4. Logistics & Delivery Analysis

This page focuses on order fulfillment and delivery performance.

### Analysis Areas

- Delivery performance
- Estimated delivery dates
- Actual delivery dates
- Delivery delays
- Order status
- Freight analysis
- Logistics trends

This analysis helps evaluate the operational side of the e-commerce business and identify delivery-related performance patterns.

---

## DAX Measures

The dashboard includes DAX measures for KPI reporting and business analysis.

### Key Measures

- Total Sales
- Total Orders
- Total Items
- Total Freight
- Average Order Value (AOV)
- Revenue
- Total Customers
- Repeat Customers
- Sales YTD
- Previous Year Sales
- Year-over-Year Growth

These measures support:

- KPI cards
- Time-series analysis
- Year-over-year comparisons
- Customer analysis
- Sales analysis
- Interactive filtering
- Business performance evaluation

---

## Key Business Questions

The dashboard was designed to answer important business questions such as:

- How are sales changing over time?
- Which product categories generate the most sales?
- Which customer states contribute the most to sales?
- What payment methods are most commonly used?
- How many customers are repeat purchasers?
- How are customers distributed by number of orders?
- Which products and categories perform best?
- How is the business performing in terms of delivery?
- Where are delivery delays occurring?
- How does freight value contribute to order cost?
- What patterns can be identified in customer purchasing behavior?
- What areas of the business require further investigation?

---

## Business Intelligence Analysis

### Sales Analysis

Sales performance was analyzed across time, customer geography, products, categories, and orders to identify major sales trends and business contributors.

### Product Analysis

Product and category performance was analyzed to identify high-performing categories and understand their contribution to overall sales.

### Customer Analysis

Customer purchasing behavior was analyzed using order frequency, customer distribution, and repeat-purchase behavior.

### Payment Analysis

Payment types and transaction patterns were analyzed to understand customer payment behavior.

### Logistics Analysis

Delivery dates, estimated delivery dates, order status, delivery performance, delays, and freight values were analyzed to evaluate operational performance.

---

## Interactive Dashboard

The Power BI dashboard provides interactive analysis through:

- KPI cards
- Slicers
- Cross-filtering
- Charts
- Tables
- Time-based analysis
- Geographic analysis
- Customer analysis
- Product analysis
- Payment analysis
- Logistics analysis

Users can interact with the dashboard to move from high-level KPIs to detailed business analysis.

---

## Power BI Dashboard Download

The complete Power BI dashboard is available as a `.pbix` file.

### Download the Power BI Dashboard

**[Olist Power BI E-Commerce Analysis - GitHub Release](https://github.com/PeyalBepari81/Peyal-s_Portfolio_project/releases/tag/v1.0.0)**

The release contains the actual Power BI file:

`olist.pbix`

**File size:** approximately 67 MB

Download the file and open it using **Microsoft Power BI Desktop** to explore the complete dashboard, data model, DAX measures, filters, slicers, and visualizations.

> **Note:** GitHub cannot open `.pbix` files directly in the browser. Microsoft Power BI Desktop is required to open and review the dashboard.

---

## Project Structure

```text
Olist_PowerBi_Analysis/
│
├── README.md
│
└── olist.pbix

## Skills Demonstrated

- Power BI
- Power Query
- DAX
- Data Modeling
- Dimensional Modeling
- KPI Development
- Business Intelligence
- Data Visualization
- Sales Analysis
- Product Analysis
- Customer Analysis
- Payment Analysis
- Logistics Analysis
- Delivery Performance Analysis
- Data Quality Analysis
- Interactive Dashboard Design
- Business Analysis

---

## Project Outcome

This project demonstrates an end-to-end Business Intelligence workflow using Power BI.

The project covers the process from raw e-commerce data and data-quality assessment through data modeling, DAX development, KPI creation, interactive visualization, and business analysis.

The final dashboard brings together sales, product, customer, payment, and logistics information into a single interactive analytical solution designed to support business decision-making.

---

## Author

**Peyal Bepari**

