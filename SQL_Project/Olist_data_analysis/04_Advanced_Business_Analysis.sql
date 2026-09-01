-- =====================================================
-- Project : Olist Brazilian E-Commerce Analysis
-- File    : 04_Advanced_Business_Analysis.sql
-- Author  : Peyal Bepari
-- Database: PostgreSQL
-- Purpose : Analyze sales performance, revenue trends,
--           and key sales metrics.
-- =====================================================

SET search_path TO olist;

-- =====================================================
-- Query 21: Identify Repeat Customers
-- =====================================================

SELECT
    c.customer_unique_id,
    COUNT(o.order_id) AS total_orders
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC;

-- Observation:
-- A total of 999 customers placed more than one order.
-- The highest repeat customer completed 17 orders, while several
-- other repeat customers placed between 4 and 9 orders.

-- Business Insight:
-- Approximately 999 customers demonstrated repeat purchasing behavior,
-- indicating the presence of a loyal customer segment. Understanding the
-- purchasing patterns of these repeat customers can support customer
-- retention strategies, loyalty programs, and personalized marketing initiatives.

-- =====================================================
-- Query 22: Customer Lifetime Value Ranking
-- =====================================================



WITH customer_clv AS (
    SELECT
        c.customer_unique_id,
        ROUND(SUM(op.payment_value), 2) AS customer_lifetime_value
    FROM customers c
    INNER JOIN orders o
        ON c.customer_id = o.customer_id
    INNER JOIN order_payments op
        ON o.order_id = op.order_id
    GROUP BY c.customer_unique_id
)

SELECT
    customer_unique_id,
    customer_lifetime_value,
    DENSE_RANK() OVER (
        ORDER BY customer_lifetime_value DESC
    ) AS revenue_rank
FROM customer_clv
LIMIT 10;


-------------------------------------------------------


WITH customer_clv AS (
    SELECT
        c.customer_unique_id,
        ROUND(SUM(op.payment_value), 2) AS customer_lifetime_value
    FROM customers c
    INNER JOIN orders o
        ON c.customer_id = o.customer_id
    INNER JOIN order_payments op
        ON o.order_id = op.order_id
    GROUP BY c.customer_unique_id
)

SELECT
    customer_unique_id,
    customer_lifetime_value,
    DENSE_RANK() OVER (
        ORDER BY customer_lifetime_value DESC
    ) AS revenue_rank
FROM customer_clv
LIMIT 10;

--Observation: 
--Customer lifetime value varies significantly among the highest-spending customers.
--The top-ranked customer generated 13,664.08, while the 10th-ranked customer generated 4,764.34 in lifetime spending.
--The ranking shows a clear difference in customer contribution to total revenue.


--Business Insight: 
--A relatively small group of high-value customers contributes substantially more revenue than other customers.
--Identifying and retaining these high-value customers can support customer retention and targeted loyalty strategies.


-- =====================================================
-- Query 23: Customer Value Segmentation and Ranking
-- =====================================================

WITH customer_revenue AS (
    SELECT
        c.customer_unique_id,
        ROUND(SUM(op.payment_value), 2) AS lifetime_value
    FROM customers c
    INNER JOIN orders o
        ON c.customer_id = o.customer_id
    INNER JOIN order_payments op
        ON o.order_id = op.order_id
  

    GROUP BY c.customer_unique_id
),

ranked_customers AS (
    SELECT
        customer_unique_id,
        lifetime_value,
        RANK() OVER (
            ORDER BY lifetime_value DESC
        ) AS revenue_rank
    FROM customer_revenue
)

SELECT
    customer_unique_id,
    lifetime_value,
    revenue_rank,
    CASE
        WHEN lifetime_value >= 5000 THEN 'High Value'
        WHEN lifetime_value >= 2000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM ranked_customers
ORDER BY revenue_rank
LIMIT 20;


-- Observation:
-- Among the top 20 customers ranked by lifetime spending,
-- 8 customers are classified as High Value, while 12 customers
-- are classified as Medium Value. No Low Value customers appear
-- among the top 20 customers.

-- Business Insight:
-- The results indicate that high-value customers represent a
-- concentrated segment of the customer base. Identifying these
-- customers can support targeted retention, loyalty, and
-- personalized engagement strategies.


-- =====================================================
-- Query 24: Highest-Revenue Product in Each Category
-- =====================================================

WITH product_revenue AS (
    SELECT
        p.product_category_name,
        oi.product_id,
        ROUND(SUM(oi.price), 2) AS total_revenue
    FROM order_items oi
    INNER JOIN products p
        ON oi.product_id = p.product_id
	WHERE p.product_category_name IS NOT NULL

    GROUP BY
        p.product_category_name,
        oi.product_id
),

ranked_products AS (
    SELECT
        product_category_name,
        product_id,
        total_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY product_category_name
            ORDER BY total_revenue DESC
        ) AS category_rank
    FROM product_revenue
)

SELECT
    product_category_name,
    product_id,
    total_revenue
FROM ranked_products
WHERE category_rank = 1
ORDER BY total_revenue DESC;

-- Observation:
-- The analysis identifies the highest-revenue product within each
-- product category. The top-performing product generated revenue
-- of 63,885.00, followed by products generating 48,899.34 and
-- 47,214.51 in their respective categories. Revenue contribution
-- varies considerably across product categories.

-- Business Insight:
-- The results highlight significant differences in product
-- performance across categories. Identifying the leading product
-- within each category can support product-level performance
-- evaluation, inventory prioritization, and category-specific
-- sales strategies.


-- =====================================================
-- Query 25: Top Revenue-Generating Category by Month
-- =====================================================

WITH monthly_category_revenue AS (
    SELECT
        DATE_TRUNC('month', o.order_purchase_timestamp) AS sales_month,
        p.product_category_name,
        ROUND(SUM(oi.price), 2) AS total_revenue
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
    WHERE p.product_category_name IS NOT NULL
    GROUP BY
        DATE_TRUNC('month', o.order_purchase_timestamp),
        p.product_category_name
),

ranked_categories AS (
    SELECT
        sales_month,
        product_category_name,
        total_revenue,
        DENSE_RANK() OVER (
            PARTITION BY sales_month
            ORDER BY total_revenue DESC
        ) AS category_rank
    FROM monthly_category_revenue
)

SELECT
    sales_month,
	TO_CHAR(sales_month,'Month'),
    product_category_name,
    total_revenue
FROM ranked_categories
WHERE category_rank = 1
ORDER BY sales_month;

-- Observation:
-- The highest-revenue product category varies across months, with
-- different categories leading monthly sales throughout the analysis
-- period. Beleza_saude, relogios_presentes, cama_mesa_banho,
-- informatica_acessorios, and esporte_lazer appear as recurring
-- top-performing categories across different months.

-- Business Insight:
-- The changing monthly category leaders indicate that product
-- category performance is not consistent over time. Tracking the
-- leading category by month can help identify shifts in customer
-- demand and support category-level inventory planning, promotional
-- campaigns, and sales strategy.


-- =====================================================
-- Query 26: Month-over-Month Revenue Growth
WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', o.order_purchase_timestamp) AS sales_month,
        ROUND(SUM(op.payment_value), 2) AS total_revenue
    FROM orders o
    INNER JOIN order_payments op
        ON o.order_id = op.order_id
    GROUP BY
        DATE_TRUNC('month', o.order_purchase_timestamp)
),

revenue_comparison AS (
    SELECT
        sales_month,
        total_revenue,
        LAG(total_revenue) OVER (
            ORDER BY sales_month
        ) AS previous_month_revenue
    FROM monthly_revenue
)

SELECT
    sales_month,
    total_revenue,
    previous_month_revenue,
    ROUND(
        total_revenue - previous_month_revenue,
        2
    ) AS revenue_change
FROM revenue_comparison
ORDER BY sales_month;

-- =====================================================

WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', o.order_purchase_timestamp) AS sales_month,
        ROUND(SUM(op.payment_value), 2) AS total_revenue
    FROM orders o
    INNER JOIN order_payments op
        ON o.order_id = op.order_id
    GROUP BY
        DATE_TRUNC('month', o.order_purchase_timestamp)
),

revenue_comparison AS (
    SELECT
        sales_month,
        total_revenue,
        LAG(total_revenue) OVER (
            ORDER BY sales_month
        ) AS previous_month_revenue
    FROM monthly_revenue
)

SELECT
    sales_month,
    total_revenue,
    previous_month_revenue,
    ROUND(
        total_revenue - previous_month_revenue,
        2
    ) AS revenue_change
FROM revenue_comparison
ORDER BY sales_month;


-- Observation:
-- Monthly revenue shows substantial fluctuations across the analysis
-- period, with both positive and negative month-over-month changes.
-- The largest positive change visible in the results occurs in
-- November 2017, when revenue increased by approximately 415,204.92
-- compared with the previous available month.
-- The results also show significant declines, including a decrease of
-- approximately 316,481.32 in December 2017.

-- Business Insight:
-- The month-over-month variation indicates that sales performance
-- is not consistent across periods. Monitoring monthly revenue changes
-- can help identify periods of strong or weak sales performance and
-- support management in evaluating seasonal demand, promotional
-- effectiveness, inventory planning, and revenue trends.



-- =====================================================
-- Query 27: Days Between Consecutive Customer Orders
-- =====================================================

WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        o.order_id,
        o.order_purchase_timestamp::date AS order_date,
        LEAD(o.order_purchase_timestamp::date) OVER (
            PARTITION BY c.customer_unique_id
            ORDER BY o.order_purchase_timestamp
        ) AS next_order_date
    FROM customers c
    INNER JOIN orders o
        ON c.customer_id = o.customer_id
)

SELECT
    customer_unique_id,
    order_id,
    order_date,
    next_order_date,
    (next_order_date - order_date) AS days_until_next_order
FROM customer_orders
WHERE next_order_date IS NOT NULL
ORDER BY days_until_next_order DESC;


-- Observation:
-- The results show substantial variation in the time between
-- consecutive orders placed by the same customers. The largest
-- observed gap is 609 days, followed by gaps of 583, 581, 573,
-- and 524 days. This indicates that some customers returned to
-- the platform after extended periods of inactivity.

-- Business Insight:
-- Analyzing the time between consecutive purchases helps measure
-- customer repurchase behavior and identify long customer inactivity
-- periods. These insights can support customer retention strategies,
-- targeted re-engagement campaigns, personalized offers, and
-- customer lifecycle management



-- =====================================================
-- Query 28: Cumulative Monthly Revenue
-- =====================================================

WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', o.order_purchase_timestamp) AS sales_month,
        ROUND(SUM(op.payment_value), 2) AS monthly_revenue
    FROM orders o
    INNER JOIN order_payments op
        ON o.order_id = op.order_id
    GROUP BY
        DATE_TRUNC('month', o.order_purchase_timestamp)
)

SELECT
    sales_month,
    monthly_revenue,
    ROUND(
        SUM(monthly_revenue) OVER (
            ORDER BY sales_month
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ),
        2
    ) AS cumulative_revenue
FROM monthly_revenue
ORDER BY sales_month;



-- Observation:
-- Cumulative revenue increases progressively as monthly revenue is
-- added to the running total. Total cumulative revenue reached
-- approximately 13.91 million by June 2018, with the strongest
-- monthly revenue contributions occurring during the later periods
-- of the analysis.

-- Business Insight:
-- Tracking cumulative revenue provides a clear view of the company's
-- overall revenue accumulation over time. This KPI can support
-- performance monitoring against revenue targets, evaluation of
-- long-term sales growth, and identification of periods contributing
-- significantly to overall business revenue.


-- =====================================================
-- Query 29: Customer Value Quartiles
-- =====================================================

WITH customer_revenue AS (
    SELECT
        c.customer_unique_id,
        ROUND(SUM(op.payment_value), 2) AS total_spent
    FROM customers c
    INNER JOIN orders o
        ON c.customer_id = o.customer_id
    INNER JOIN order_payments op
        ON o.order_id = op.order_id
    GROUP BY
        c.customer_unique_id
),

customer_quartiles AS (
    SELECT
        customer_unique_id,
        total_spent,
        NTILE(4) OVER (
            ORDER BY total_spent DESC
        ) AS value_quartile
    FROM customer_revenue
)

SELECT
    customer_unique_id,
    total_spent,
    value_quartile,
    CASE
        WHEN value_quartile = 1 THEN 'Top 25% Customers'
        WHEN value_quartile = 2 THEN 'High-Mid Value Customers'
        WHEN value_quartile = 3 THEN 'Low-Mid Value Customers'
        WHEN value_quartile = 4 THEN 'Bottom 25% Customers'
    END AS customer_segment
FROM customer_quartiles
ORDER BY total_spent DESC;


-- Observation:
-- Customers are distributed into four approximately equal spending
-- groups based on their total purchase value. The highest-spending
-- customers are classified into the Top 25% segment, while the
-- remaining customers are progressively classified into high-mid,
-- low-mid, and bottom 25% value segments.

-- Business Insight:
-- Customer value segmentation provides a structured view of the
-- customer base based on spending behavior. The Top 25% segment can
-- be prioritized for retention and loyalty initiatives, while lower-
-- value segments can be analyzed for opportunities to increase
-- engagement, repeat purchases, and customer lifetime value.


-- =====================================================
-- Query 30: Customer Value & Purchase Performance
-- =====================================================

WITH customer_metrics AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_orders,
        ROUND(SUM(op.payment_value), 2) AS total_spent,
        ROUND(AVG(op.payment_value), 2) AS avg_order_value
    FROM customers c
    INNER JOIN orders o
        ON c.customer_id = o.customer_id
    INNER JOIN order_payments op
        ON o.order_id = op.order_id
    GROUP BY
        c.customer_unique_id
),

ranked_customers AS (
    SELECT
        customer_unique_id,
        total_orders,
        total_spent,
        avg_order_value,

        RANK() OVER (
            ORDER BY total_spent DESC
        ) AS spending_rank

    FROM customer_metrics
)

SELECT
    customer_unique_id,
    total_orders,
    total_spent,
    avg_order_value,
    spending_rank,

    CASE
        WHEN total_spent >= 5000 THEN 'High Value'
        WHEN total_spent >= 2000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment

FROM ranked_customers
ORDER BY spending_rank
LIMIT 20;



-- Observation:
-- The results show substantial variation in customer spending,
-- order frequency, and average order value. The highest-ranked
-- customer generated total spending of 13,664.08 from a single order,
-- while other high-value customers generated their spending across
-- multiple orders. The Top 20 results include both High Value and
-- Medium Value customer segments based on the defined spending
-- thresholds.

-- Business Insight:
-- Combining total spending, order frequency, and average order value
-- provides a broader view of customer purchasing behavior than using
-- revenue alone. This analysis can support customer segmentation,
-- retention planning, identification of high-value customers, and
-- development of targeted marketing strategies based on customer
-- purchasing patterns.



