-- =====================================================
-- Project : Olist Brazilian E-Commerce Analysis
-- File    : 03_Sales_Analysis.sql
-- Author  : Peyal Bepari
-- Database: PostgreSQL
-- Purpose : Analyze sales performance, revenue trends,
--           and key sales metrics.
-- =====================================================

SET search_path TO olist;

-- =====================================================
-- SALES ANALYSIS
-- =====================================================

-- =====================================================
-- Query 1: Calculate Total Revenue Generated
-- =====================================================

SELECT
    ROUND(SUM(payment_value), 2) AS total_revenue
FROM order_payments;

-- Observation:
-- The business generated a total revenue of 16,008,872 from all recorded customer payments.

-- Business Insight:
-- This KPI represents the total income generated from customer purchases
-- and serves as the foundation for evaluating overall sales performance.


-- =====================================================
-- Query 2: Calculate Total Number of Orders
-- =====================================================

SELECT
    COUNT(order_id) AS total_orders
FROM orders;

-- Observation:
-- The dataset contains 99,441 customer orders.

-- Business Insight:
-- A total of 99,441 orders indicates the overall transaction volume
-- and serves as a key metric for evaluating customer purchasing activity.


-- =====================================================
-- Query 3: Calculate Total Products Sold
-- =====================================================

SELECT COUNT(product_id) FROM order_items;

-- Observation:
-- A total of 112,650 products were sold across all customer orders.

-- Business Insight:
-- The business sold 112,650 products, indicating strong customer
-- purchasing activity and providing a key measure of overall sales volume.


-- =====================================================
-- Query 4: Calculate Average Order Value (AOV)
-- =====================================================

SELECT
    ROUND(AVG(payment_value), 2) AS average_order_value
FROM order_payments;


-- Business Insight:
-- On average, each customer order generated 154.10 in revenue.
-- This KPI reflects customer spending behavior and helps evaluate
-- pricing strategy, promotional effectiveness, and overall sales performance.


-- =====================================================
-- Query 5: Monthly Sales Trend
-- =====================================================


SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS sales_month,
    ROUND(SUM(op.payment_value), 2) AS total_revenue
FROM orders o
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY sales_month
ORDER BY sales_month;


-- =====================================================
-- Query 5: Monthly Sales Trend
-- =====================================================

SELECT
    TO_CHAR(o.order_purchase_timestamp, 'Month') AS sales_month,
    ROUND(SUM(op.payment_value), 2) AS total_revenue
FROM orders o
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY TO_CHAR(o.order_purchase_timestamp, 'Month')
ORDER BY MIN(o.order_purchase_timestamp);


-----------------------------------------------------------

SELECT
    TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM') AS sales_month,
    ROUND(SUM(op.payment_value), 2) AS total_revenue
FROM orders o
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY sales_month
ORDER BY sales_month;

-- Observation:
-- Monthly sales revenue fluctuated throughout the analysis period
-- from September 2016 to September 2018. Revenue reached its peak
-- during the middle and end of 2017, while lower sales were observed
-- in the initial months of the dataset. The final month (September 2018)
-- contains only partial data and therefore reports significantly lower revenue.

-- Business Insight:
-- Monthly revenue does not follow a consistent upward trend.
-- Instead, sales fluctuate over time, indicating the influence of
-- seasonality, promotional campaigns, and changing customer demand.
-- Monitoring these patterns helps improve sales forecasting,
-- inventory management, and marketing strategies.


-- =====================================================
-- Query 6: Top 10 Best-Selling Product Categories
-- =====================================================


-- =====================================================
-- Query 6: Top 10 Best-Selling Product Categories
-- =====================================================

SELECT
    pct.product_category_name_english AS product_category,
    ROUND(SUM(oi.price), 2) AS category_revenue
FROM order_items oi
INNER JOIN products p
    ON oi.product_id = p.product_id
INNER JOIN product_category_translation pct
    ON p.product_category_name = pct.product_category_name
GROUP BY pct.product_category_name_english
ORDER BY category_revenue DESC
LIMIT 10;

-- Observation:
-- The top 10 product categories generated the highest sales revenue.
-- Health & Beauty generated the highest revenue (1,256,681.34),
-- followed by Watches & Gifts (1,205,005.68) and Bed Bath Table
-- (1,036,988.68). These categories contributed significantly to
-- the overall business revenue.

-- Business Insight:
-- High-revenue product categories represent the company's strongest
-- market segments. These insights help prioritize inventory planning,
-- marketing investments, and product assortment strategies to maximize
-- sales and profitability.


-- =====================================================
-- Query 7: Top 10 Best-Selling Products by Revenue
-- =====================================================

SELECT
    oi.product_id,
    pct.product_category_name_english AS category,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
INNER JOIN products p
    ON oi.product_id = p.product_id
INNER JOIN product_category_translation pct
    ON p.product_category_name = pct.product_category_name
GROUP BY oi.product_id, pct.product_category_name_english
ORDER BY total_revenue DESC
LIMIT 10;

-- Observation:
-- The query identifies the top 10 sellers based on total sales revenue.
-- The highest-performing seller generated the maximum revenue,
-- while the remaining top sellers also contributed significantly
-- to the overall marketplace sales.

-- Business Insight:
-- Identifying high-performing sellers helps evaluate seller performance,
-- optimize seller partnerships, and develop targeted incentive programs.
-- These insights also support inventory planning and marketplace growth strategies.


-- =====================================================
-- Query 9: Top 10 Customers by Total Spending
-- =====================================================

SELECT c.customer_unique_id,sum(op.payment_value) AS total_spent
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN order_payments op 
ON o.order_id = op.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spent DESC
LIMIT 10;

-- Observation:
-- The top 10 customers were identified based on their total spending.
-- The highest-spending customer contributed a total of 13,664.08,
-- while the remaining top customers also generated substantial revenue.
-- This indicates that a small group of customers contributes significantly
-- to the overall business revenue.

-- Business Insight:
-- Identifying high-value customers enables the business to design
-- personalized marketing campaigns, loyalty programs, and retention
-- strategies. Focusing on these customers can improve customer lifetime
-- value and maximize long-term revenue.



-- =====================================================
-- Query 10: Top 10 Cities by Sales Revenue
-- =====================================================


SELECT
    c.customer_city,
    ROUND(SUM(op.payment_value), 2) AS total_revenue
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN order_payments op
    ON o.order_id = op.order_id
GROUP BY c.customer_city
ORDER BY total_revenue DESC
LIMIT 10;

-- Observation:
-- Sao Paulo generated the highest sales revenue (2,203,373.09),
-- followed by Rio de Janeiro (1,161,927.36) and Belo Horizonte
-- (421,765.12). The top 10 customer cities account for a substantial
-- share of the total sales revenue, indicating that revenue is
-- concentrated in a few major urban markets.

-- Business Insight:
-- Identifying high-revenue cities helps businesses understand their
-- strongest regional markets. These insights support location-based
-- marketing campaigns, inventory allocation, logistics planning,
-- and future business expansion decisions.



-- =====================================================
-- Query 11: Top 10 States by Sales Revenue
-- =====================================================

SELECT
    c.customer_state,
    ROUND(SUM(op.payment_value), 2) AS total_revenue
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN order_payments op
    ON o.order_id = op.order_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC
LIMIT 10;


-- Observation:
-- São Paulo (SP) generated the highest sales revenue (5,998,226.96),
-- followed by Rio de Janeiro (RJ) with 2,144,379.69 and Minas Gerais (MG)
-- with 1,872,257.26. The top 10 states account for a substantial portion
-- of the total sales revenue, indicating that customer spending is
-- concentrated across a few major states. 

-- Business Insight:
-- Revenue concentration across a few states highlights key regional markets.
-- Understanding state-level sales performance enables more effective
-- resource allocation and supports data-driven business planning.


-- =====================================================
-- Query 12: Top 10 Sellers by Revenue
-- =====================================================


SELECT
    oi.seller_id,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
GROUP BY oi.seller_id
ORDER BY total_revenue DESC
LIMIT 10;

-- Observation:
-- The top 10 sellers were ranked based on total sales revenue.
-- The highest-performing seller generated a total revenue of 229,472.63,
-- followed by sellers with revenues of 222,776.05 and 200,472.92.
-- The results indicate that seller revenue varies considerably across the marketplace.

-- Business Insight:
-- Identifying high-performing sellers helps evaluate seller performance,
-- optimize marketplace partnerships, and support data-driven decisions
-- related to seller incentives, inventory management, and platform growth.


-- =====================================================
-- Query 13: Top 10 Sellers by Number of Orders
-- =====================================================

SELECT
    seller_id,
    COUNT(*) AS total_orders
FROM order_items
GROUP BY seller_id
ORDER BY total_orders DESC
LIMIT 10;

-- Observation:
-- The top 10 sellers were ranked based on the total number of order items sold.
-- The highest-performing seller fulfilled 2,033 order items, followed by
-- sellers with 1,987 and 1,931 order items. The results indicate that
-- seller order volumes vary significantly across the marketplace.

-- Business Insight:
-- Analyzing seller order volumes helps identify the marketplace's most
-- active sellers. These insights support seller performance evaluation,
-- operational planning, and the development of targeted seller engagement
-- and incentive programs.


-- =====================================================
-- Query 14: Average Revenue per Seller
-- =====================================================

SELECT
    ROUND(AVG(seller_revenue), 2) AS avg_revenue_per_seller
FROM (
    SELECT
        seller_id,
        SUM(price) AS seller_revenue
    FROM order_items
    GROUP BY seller_id
) AS seller_sales;

-- Observation:
-- The average revenue generated per seller is 4,391.48.
-- This metric represents the average total sales revenue earned
-- by each seller across the marketplace.

-- Business Insight:
-- Average revenue per seller provides a benchmark for evaluating
-- overall seller performance. Comparing individual seller revenue
-- against this benchmark helps identify high-performing sellers
-- and opportunities to improve seller productivity.


-- =====================================================
-- Query 15: Seller Performance Classification
-- =====================================================

SELECT
    seller_category,
    COUNT(*) AS total_sellers
FROM (
    SELECT
        seller_id,
        SUM(price) AS total_revenue,
        CASE
            WHEN SUM(price) >= 10000 THEN 'High Revenue'
            WHEN SUM(price) >= 5000 THEN 'Medium Revenue'
            ELSE 'Low Revenue'
        END AS seller_category
    FROM order_items
    GROUP BY seller_id
) AS seller_performance
GROUP BY seller_category
ORDER BY total_sellers DESC;

-- Observation:
-- Sellers were classified into three revenue segments based on total sales.
-- The majority of sellers (2,529) fall into the Low Revenue category,
-- while 292 sellers are classified as High Revenue and 274 as Medium Revenue.
-- This distribution indicates that seller revenue is concentrated among
-- a relatively small proportion of sellers.

-- Business Insight:
-- Revenue segmentation helps identify different seller performance groups,
-- enabling targeted business strategies such as incentive programs for
-- high-performing sellers, growth initiatives for medium-performing sellers,
-- and support programs to improve the performance of low-revenue sellers.


-- =====================================================
-- Query 16: Top 10 Customers by Number of Orders
-- =====================================================

SELECT c.customer_unique_id,COUNT(o.order_id) as total_number_of_orders
FROM customers c 
join orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
ORDER BY total_number_of_orders DESC
LIMIT 10 ;


-- Observation:
-- The customer with the highest purchase frequency placed 17 orders,
-- followed by another customer with 9 orders. Most of the remaining
-- top customers placed between 6 and 7 orders, indicating that only
-- a small number of customers made frequent repeat purchases.

-- Business Insight:
-- Customer order frequency is an important indicator of customer loyalty
-- and retention. Identifying repeat customers enables businesses to
-- design personalized marketing campaigns, loyalty programs, and
-- customer retention strategies to encourage long-term engagement.


-- =====================================================
-- Query 17: Payment Method Distribution
-- =====================================================


SELECT
    payment_type,
    COUNT(*) AS total_transactions,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM order_payments
GROUP BY payment_type
ORDER BY total_transactions DESC;



-- Observation:
-- Credit card was the most frequently used payment method, accounting
-- for 76,795 transactions (73.92%). Boleto ranked second with
-- 19,784 transactions (19.04%), followed by voucher (5.56%) and
-- debit card (1.47%). Only three transactions were recorded as
-- 'not_defined', indicating that nearly all payment records have
-- valid payment method information.


-- Business Insight:
-- The distribution of payment methods highlights customer payment
-- preferences, with credit cards dominating transaction volume.
-- Understanding payment behavior can support payment service
-- optimization, promotional campaign planning, and improvements
-- to the checkout experience.


-- =====================================================
-- Query 18: Average Installments by Payment Method
-- =====================================================
SELECT
    payment_type,
    ROUND(AVG(payment_installments), 2) AS avg_installments,
    MIN(payment_installments) AS min_installments,
    MAX(payment_installments) AS max_installments
FROM order_payments
GROUP BY payment_type
ORDER BY avg_installments DESC;


-- Observation:
-- Credit card payments had the highest average number of installments
-- (3.51), with installment counts ranging from 0 to 24. All other
-- payment methods were consistently used as single-installment payments,
-- with an average, minimum, and maximum of 1 installment.

-- Business Insight:
-- Customers primarily use installment payments when paying by credit
-- card, while boleto, debit card, and voucher transactions are almost
-- exclusively completed in a single payment. This indicates that credit
-- cards provide greater payment flexibility for customers.


-- =====================================================
-- Query 19: Average Order Delivery Time
-- =====================================================

SELECT
    ROUND(
        AVG(
            order_delivered_customer_date::date -
            order_purchase_timestamp::date
        ),
        2
    ) AS avg_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

-- Observation:
-- The average time between order purchase and customer delivery
-- was 12.50 days. This metric represents the overall delivery
-- performance across all successfully delivered orders.

-- Business Insight:
-- Average delivery time is a key logistics performance indicator.
-- Monitoring this metric helps evaluate supply chain efficiency,
-- delivery service performance, and the overall customer fulfillment
-- experience.

-- =====================================================
-- Query 20: Average Delay Against Estimated Delivery Date
-- =====================================================


SELECT
    ROUND(
        AVG(
            order_delivered_customer_date::date -
            order_estimated_delivery_date::date
        ),
        2
    ) AS avg_delivery_delay_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;


-- Observation:
-- On average, customer orders were delivered 11.88 days before
-- the estimated delivery date. This indicates that most deliveries
-- were completed well ahead of the promised delivery schedule.

-- Business Insight:
-- Delivering orders ahead of the estimated delivery date reflects
-- strong logistics performance and efficient order fulfillment.
-- Consistently early deliveries can enhance customer satisfaction,
-- improve service reliability, and strengthen customer trust.

