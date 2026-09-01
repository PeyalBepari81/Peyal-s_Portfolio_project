SET search_path TO olist;

select * from customers;

-- =====================================================
-- CUSTOMERS TABLE DATA QUALITY CHECKS
-- =====================================================

-- -----------------------------------------------------
-- 1. Check Total Number of Rows
-- -----------------------------------------------------

SELECT COUNT(*) AS total_rows
FROM customers;

-- Observation:
-- rows: 99,441


-- -----------------------------------------------------
-- 2. Preview First 10 Rows
-- -----------------------------------------------------

SELECT *
FROM customers
LIMIT 10;

-- Observation:
-- Verify that the data has been imported correctly.


-- -----------------------------------------------------
-- 3. Check NULL Values
-- -----------------------------------------------------

SELECT
SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS customer_id_null,
SUM(CASE WHEN customer_unique_id IS NULL THEN 1 ELSE 0 END) AS customer_unique_id_null,
SUM(CASE WHEN customer_zip_code_prefix IS NULL THEN 1 ELSE 0 END) AS zip_code_null,
SUM(CASE WHEN customer_city IS NULL THEN 1 ELSE 0 END) AS city_null,
SUM(CASE WHEN customer_state IS NULL THEN 1 ELSE 0 END) AS state_null
FROM customers;

-- Observation:
-- Expected: No NULL values in any column.


-- -----------------------------------------------------
-- 4. Check Duplicate Customer IDs
-- -----------------------------------------------------

SELECT customer_id,
COUNT(*)
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Observation:
-- Expected: No duplicate customer_id values.


-- -----------------------------------------------------
-- 5. Check Duplicate Customer Unique IDs
-- -----------------------------------------------------

SELECT customer_unique_id,
COUNT(*)
FROM customers
GROUP BY customer_unique_id
HAVING COUNT(*) > 1;

-- Observation:
-- Duplicate customer_unique_id values are here because
-- the same customer may place multiple orders.


-- -----------------------------------------------------
-- 6. Check Blank City Names
-- -----------------------------------------------------

SELECT COUNT(*) AS blank_city
FROM customers
WHERE TRIM(customer_city) = '';

-- Observation:
-- Blank City Names 0


-- -----------------------------------------------------
-- 7. Check Blank State Codes
-- -----------------------------------------------------

SELECT COUNT(*) AS blank_state
FROM customers
WHERE TRIM(customer_state) = '';

-- Observation:
--  Blank State Codes 0


-- -----------------------------------------------------
-- 8. Check Numeric City Names
-- -----------------------------------------------------

SELECT *
FROM customers
WHERE customer_city ~ '^[0-9]+$';

-- Observation:
--  city names contain only numeric values is zero.


-- -----------------------------------------------------
-- 9. Distinct States
-- -----------------------------------------------------

SELECT customer_state,
COUNT(*) AS total_customers
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC;

-- Observation:
-- Verify that all Brazilian state codes appear valid.


-- =====================================================
-- Final Observation
-- =====================================================

-- The customers table has been successfully validated.
-- All 99,441 records were imported correctly.
-- No NULL values were found in any mandatory column.
-- No duplicate customer_id values exist.
-- Blank city and state values were not detected.
-- Customer_unique_id contains duplicates as expected because
-- a single customer can place multiple orders.
-- Overall, the table is clean, consistent, and ready for analysis
-- without requiring any data cleaning.




-- =====================================================
-- ORDERS TABLE DATA QUALITY CHECKS
-- =====================================================

-- -----------------------------------------------------
-- 1. Check Total Number of Rows
-- -----------------------------------------------------

SELECT COUNT(*) AS total_rows
FROM orders;

-- Observation:
--  rows: 99,441


-- -----------------------------------------------------
-- 2. Preview First 10 Rows
-- -----------------------------------------------------

SELECT *
FROM orders
LIMIT 10;

-- Observation:
-- Verify that the data has been imported correctly.


-- -----------------------------------------------------
-- 3. Check NULL Values
-- -----------------------------------------------------

SELECT
SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS order_id_null,
SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS customer_id_null,
SUM(CASE WHEN order_status IS NULL THEN 1 ELSE 0 END) AS order_status_null,
SUM(CASE WHEN order_purchase_timestamp IS NULL THEN 1 ELSE 0 END) AS purchase_timestamp_null,
SUM(CASE WHEN order_approved_at IS NULL THEN 1 ELSE 0 END) AS approved_at_null,
SUM(CASE WHEN order_delivered_carrier_date IS NULL THEN 1 ELSE 0 END) AS carrier_date_null,
SUM(CASE WHEN order_delivered_customer_date IS NULL THEN 1 ELSE 0 END) AS customer_delivery_date_null,
SUM(CASE WHEN order_estimated_delivery_date IS NULL THEN 1 ELSE 0 END) AS estimated_delivery_date_null
FROM orders;

-- Observation:
-- order_approved_at, order_delivered_carrier_date,
-- and order_delivered_customer_date may contain NULL values
-- because some orders were cancelled, unavailable, or not delivered.


-- -----------------------------------------------------
-- 4. Check Duplicate Order IDs
-- -----------------------------------------------------

SELECT order_id,
COUNT(*)
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Observation:
-- Expected: No duplicate order_id values.


-- -----------------------------------------------------
-- 5. Check Blank Order Status
-- -----------------------------------------------------

SELECT COUNT(*) AS blank_order_status
FROM orders
WHERE TRIM(order_status) = '';

-- Observation:
--  0


-- -----------------------------------------------------
-- 6. Check Distinct Order Status
-- -----------------------------------------------------

SELECT
order_status,
COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Observation:
-- Verify that all order statuses are valid.


-- -----------------------------------------------------
-- 7. Check Invalid Delivery Dates
-- -----------------------------------------------------

SELECT COUNT(*) AS invalid_delivery_dates
FROM orders
WHERE order_delivered_customer_date < order_purchase_timestamp;

-- Observation:
--  0


-- -----------------------------------------------------
-- 8. Check Referential Integrity
-- -----------------------------------------------------

SELECT COUNT(*) AS missing_customers
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Observation:
-- Expected: 0
-- Every order should belong to an existing customer.


-- =====================================================
-- Final Observation
-- =====================================================

-- The orders table has been successfully validated.
-- All 99,441 records were imported correctly.
-- No duplicate order_id values were found.
-- No blank order_status values were detected.
-- NULL values in order_approved_at,
-- order_delivered_carrier_date, and
-- order_delivered_customer_date are expected because some
-- orders were cancelled, unavailable, or still in progress.
-- No invalid delivery dates were found.
-- Referential integrity with the customers table is maintained.
-- Overall, the table is clean, internally consistent,
-- and ready for analysis without requiring data cleaning.




-- =====================================================
-- PRODUCTS TABLE DATA QUALITY CHECKS
-- =====================================================

-- -----------------------------------------------------
-- 1. Check Total Number of Rows
-- -----------------------------------------------------

SELECT COUNT(*) AS total_rows
FROM products;

-- Observation:
-- Total records imported: 32,951.
-- The row count matches the original dataset.


-- -----------------------------------------------------
-- 2. Preview First 10 Rows
-- -----------------------------------------------------

SELECT *
FROM products
LIMIT 10;

-- Observation:
-- The data is correctly imported, and all columns are displayed as expected.


-- -----------------------------------------------------
-- 3. Check NULL Values
-- -----------------------------------------------------

SELECT
SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS product_id_null,
SUM(CASE WHEN product_category_name IS NULL THEN 1 ELSE 0 END) AS category_name_null,
SUM(CASE WHEN product_name_lenght IS NULL THEN 1 ELSE 0 END) AS product_name_length_null,
SUM(CASE WHEN product_description_lenght IS NULL THEN 1 ELSE 0 END) AS description_length_null,
SUM(CASE WHEN product_photos_qty IS NULL THEN 1 ELSE 0 END) AS photos_qty_null,
SUM(CASE WHEN product_weight_g IS NULL THEN 1 ELSE 0 END) AS weight_null,
SUM(CASE WHEN product_length_cm IS NULL THEN 1 ELSE 0 END) AS length_null,
SUM(CASE WHEN product_height_cm IS NULL THEN 1 ELSE 0 END) AS height_null,
SUM(CASE WHEN product_width_cm IS NULL THEN 1 ELSE 0 END) AS width_null
FROM products;

-- Observation:
-- product_category_name contains 610 NULL values.
-- product_name_lenght, product_description_lenght, and
-- product_photos_qty also contain 610 NULL values each.
-- product_weight_g, product_length_cm,
-- product_height_cm, and product_width_cm contain
-- only 2 NULL values each.
-- These missing values are present in the original
-- Olist dataset and do not indicate an import error.

-- -----------------------------------------------------
-- 4. Check Duplicate Product IDs
-- -----------------------------------------------------

SELECT
product_id,
COUNT(*)
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- Observation:
-- No duplicate product_id values were found.


-- -----------------------------------------------------
-- 5. Check Blank Category Names
-- -----------------------------------------------------

SELECT COUNT(*) AS blank_category_names
FROM products
WHERE product_category_name IS NOT NULL
AND TRIM(product_category_name) = '';

-- Observation:
-- No blank category names were found.


-- -----------------------------------------------------
-- 6. Check Invalid Product Dimensions
-- -----------------------------------------------------

SELECT COUNT(*) AS invalid_dimensions
FROM products
WHERE product_weight_g <= 0
   OR product_length_cm <= 0
   OR product_height_cm <= 0
   OR product_width_cm <= 0;

--------------------------------------------------------

SELECT COUNT(*) AS invalid_dimensions
FROM products
WHERE product_weight_g < 0
   OR product_length_cm < 0
   OR product_height_cm < 0
   OR product_width_cm < 0;

--------------------------------------------------------
SELECT
    product_id,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM products
WHERE product_weight_g <= 0
   OR product_length_cm <= 0
   OR product_height_cm <= 0
   OR product_width_cm <= 0;

----------------------------------------------------


SELECT product_id,
       product_weight_g
FROM products
WHERE product_weight_g <= 0;
   
-- Observation:
-- A total of 4 products have a product_weight_g value of 0.
-- Their dimensions (length, height, and width) contain valid
-- positive values. Since a physical product cannot have zero
-- weight, these records are considered data quality issues in
-- the original dataset and may require further investigation
-- before analyses involving product weight.


-- -----------------------------------------------------
-- 7. Check Referential Integrity
-- -----------------------------------------------------

SELECT COUNT(*) AS missing_categories
FROM products p
LEFT JOIN product_category_translation pct
ON p.product_category_name = pct.product_category_name
WHERE p.product_category_name IS NOT NULL
AND pct.product_category_name IS NULL;


-- Observation:
-- A total of 13 products have category names that do not have
-- corresponding entries in the product_category_translation table.
-- This indicates minor inconsistencies in the original Olist dataset
-- and may affect analyses that rely on English category translations.


-- -----------------------------------------------------
-- 8. Count Distinct Product Categories
-- -----------------------------------------------------

SELECT COUNT(DISTINCT product_category_name) AS total_categories
FROM products;

-- Observation:
-- The dataset contains the 73 number of distinct product categories.


-- =====================================================
-- Final Observation
-- =====================================================
-- The products table has been successfully validated.
-- All 32,951 records were imported correctly.
-- No duplicate product_id values or blank category names were found.
-- A total of 610 products have missing category and product attribute
-- information, which originates from the original Olist dataset.
-- Four products have a product weight of 0 g, while their other
-- dimensions are valid. These records have been retained in the raw
-- dataset and can be handled during data cleaning if required.
-- Additionally, 13 product categories do not have matching entries
-- in the product_category_translation table, indicating minor
-- inconsistencies in the source data.
-- Overall, the table is suitable for analysis, with a few documented
-- data quality issues that should be considered during downstream analysis.




-- =====================================================
-- SELLERS TABLE DATA QUALITY CHECKS
-- =====================================================

-- -----------------------------------------------------
-- 1. Check Total Number of Rows
-- -----------------------------------------------------

SELECT COUNT(*) AS total_rows
FROM sellers;

-- Observation:
-- Total records imported: 3,095.
-- The row count matches the original dataset.


-- -----------------------------------------------------
-- 2. Preview First 10 Rows
-- -----------------------------------------------------

SELECT *
FROM sellers
LIMIT 10;

-- Observation:
-- The data is correctly imported, and all columns are displayed as expected.


-- -----------------------------------------------------
-- 3. Check NULL Values
-- -----------------------------------------------------

SELECT
SUM(CASE WHEN seller_id IS NULL THEN 1 ELSE 0 END) AS seller_id_null,
SUM(CASE WHEN seller_zip_code_prefix IS NULL THEN 1 ELSE 0 END) AS zip_code_null,
SUM(CASE WHEN seller_city IS NULL THEN 1 ELSE 0 END) AS city_null,
SUM(CASE WHEN seller_state IS NULL THEN 1 ELSE 0 END) AS state_null
FROM sellers;

-- Observation:
-- 0  NULL count returned by the query.


-- -----------------------------------------------------
-- 4. Check Duplicate Seller IDs
-- -----------------------------------------------------

SELECT
seller_id,
COUNT(*)
FROM sellers
GROUP BY seller_id
HAVING COUNT(*) > 1;

-- Observation:
-- Record whether duplicate seller_id values exist - 0


-- -----------------------------------------------------
-- 5. Check Blank City Names
-- -----------------------------------------------------

SELECT COUNT(*) AS blank_city
FROM sellers
WHERE TRIM(seller_city) = '';

-- Observation:
-- Record the number of blank city names - 0


-- -----------------------------------------------------
-- 6. Check Blank State Codes
-- -----------------------------------------------------

SELECT COUNT(*) AS blank_state
FROM sellers
WHERE TRIM(seller_state) = '';

-- Observation:
-- the number of blank state codes - 0


-- -----------------------------------------------------
-- 7. Check Numeric City Names
-- -----------------------------------------------------

SELECT *
FROM sellers
WHERE seller_city ~ '^[0-9]+$';

-- Observation:
-- One  city names contain only numeric values 04482255.


-- -----------------------------------------------------
-- 8. Distinct States
-- -----------------------------------------------------

SELECT
seller_state,
COUNT(*) AS total_sellers
FROM sellers
GROUP BY seller_state
ORDER BY total_sellers DESC;

-- Observation:
--  all seller state codes are valid.


-- =====================================================
-- Final Observation
-- =====================================================

-- -- =====================================================
-- Final Observation
-- =====================================================
-- The sellers table has been successfully validated.
-- All 3,095 records were imported correctly.
-- No duplicate seller_id values were found.
-- No NULL values or blank entries were detected in the
-- seller_id, seller_zip_code_prefix, seller_city, and
-- seller_state columns.
-- 1 seller_city values contain only numeric
-- characters. These appear to be data quality issues in the
-- original Olist dataset and have been retained in the raw
-- dataset for documentation purposes.
-- Overall, the table is clean, internally consistent, and
-- ready for analysis, with only minor data quality issues
-- identified in the original source data.



-- =====================================================
-- ORDER_ITEMS TABLE DATA QUALITY CHECKS
-- =====================================================

-- -----------------------------------------------------
-- 1. Check Total Number of Rows
-- -----------------------------------------------------

SELECT COUNT(*) AS total_rows
FROM order_items;

-- Observation:
-- Total records imported: 112,650.
-- The row count matches the original dataset.


-- -----------------------------------------------------
-- 2. Preview First 10 Rows
-- -----------------------------------------------------

SELECT *
FROM order_items
LIMIT 10;

-- Observation:
-- The data is correctly imported, and all columns are displayed as expected.


-- -----------------------------------------------------
-- 3. Check NULL Values
-- -----------------------------------------------------

SELECT
SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS order_id_null,
SUM(CASE WHEN order_item_id IS NULL THEN 1 ELSE 0 END) AS order_item_id_null,
SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS product_id_null,
SUM(CASE WHEN seller_id IS NULL THEN 1 ELSE 0 END) AS seller_id_null,
SUM(CASE WHEN shipping_limit_date IS NULL THEN 1 ELSE 0 END) AS shipping_limit_date_null,
SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS price_null,
SUM(CASE WHEN freight_value IS NULL THEN 1 ELSE 0 END) AS freight_value_null
FROM order_items;

-- Observation:
-- 0 NULL count returned by the query.


-- -----------------------------------------------------
-- 4. Check Duplicate Composite Primary Key
-- -----------------------------------------------------

SELECT
order_id,
order_item_id,
COUNT(*)
FROM order_items
GROUP BY order_id, order_item_id
HAVING COUNT(*) > 1;

-- Observation:
-- 0 duplicate composite primary keys exist.


-- -----------------------------------------------------
-- 5. Check Blank Product IDs
-- -----------------------------------------------------

SELECT COUNT(*) AS blank_product_id
FROM order_items
WHERE TRIM(product_id) = '';

-- Observation:
-- 0 number of blank product IDs.


-- -----------------------------------------------------
-- 6. Check Blank Seller IDs
-- -----------------------------------------------------

SELECT COUNT(*) AS blank_seller_id
FROM order_items
WHERE TRIM(seller_id) = '';

-- Observation:
--0 number of blank seller IDs.


-- -----------------------------------------------------
-- 7. Check Invalid Prices
-- -----------------------------------------------------

SELECT COUNT(*) AS invalid_price
FROM order_items
WHERE price < 0;

-- Observation:
-- 0 negative prices exist.


-- -----------------------------------------------------
-- 8. Check Invalid Freight Values
-- -----------------------------------------------------

SELECT COUNT(*) AS invalid_freight
FROM order_items
WHERE freight_value < 0;

-- Observation:
--0 negative freight values exist.


-- -----------------------------------------------------
-- 9. Check Referential Integrity (Orders)
-- -----------------------------------------------------

SELECT COUNT(*) AS missing_orders
FROM order_items oi
LEFT JOIN orders o
ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Observation:
-- 0 number of missing order references.


-- -----------------------------------------------------
-- 10. Check Referential Integrity (Products)
-- -----------------------------------------------------

SELECT COUNT(*) AS missing_products
FROM order_items oi
LEFT JOIN products p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Observation:
--0 number of missing product references.


-- -----------------------------------------------------
-- 11. Check Referential Integrity (Sellers)
-- -----------------------------------------------------

SELECT COUNT(*) AS missing_sellers
FROM order_items oi
LEFT JOIN sellers s
ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL;

-- Observation:
--0 number of missing seller references.


-- =====================================================
-- Final Observation
-- =====================================================
-- The order_items table has been successfully validated.
-- All 112,650 records were imported correctly.
-- No NULL values were found in any mandatory column.
-- No duplicate composite primary key values
-- (order_id, order_item_id) were detected.
-- No blank product_id or seller_id values were found.
-- All product prices and freight values are valid, with
-- no negative values identified.
-- Referential integrity with the orders, products, and
-- sellers tables is fully maintained, with no missing
-- foreign key references.
-- Overall, the table is clean, internally consistent,
-- and ready for analysis without requiring any data cleaning.





-- =====================================================
-- ORDER_PAYMENTS TABLE DATA QUALITY CHECKS
-- =====================================================

-- -----------------------------------------------------
-- 1. Check Total Number of Rows
-- -----------------------------------------------------

SELECT COUNT(*) AS total_rows
FROM order_payments;

-- Observation:
-- Total records imported: 103,886.
-- The row count matches the original dataset.


-- -----------------------------------------------------
-- 2. Preview First 10 Rows
-- -----------------------------------------------------

SELECT *
FROM order_payments
LIMIT 10;

-- Observation:
-- The data is correctly imported, and all columns are displayed as expected.


-- -----------------------------------------------------
-- 3. Check NULL Values
-- -----------------------------------------------------

SELECT
SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS order_id_null,
SUM(CASE WHEN payment_sequential IS NULL THEN 1 ELSE 0 END) AS payment_sequential_null,
SUM(CASE WHEN payment_type IS NULL THEN 1 ELSE 0 END) AS payment_type_null,
SUM(CASE WHEN payment_installments IS NULL THEN 1 ELSE 0 END) AS payment_installments_null,
SUM(CASE WHEN payment_value IS NULL THEN 1 ELSE 0 END) AS payment_value_null
FROM order_payments;

-- Observation:
-- 0 NULL count returned by the query.


-- -----------------------------------------------------
-- 4. Check Duplicate Composite Primary Key
-- -----------------------------------------------------

SELECT
order_id,
payment_sequential,
COUNT(*)
FROM order_payments
GROUP BY order_id, payment_sequential
HAVING COUNT(*) > 1;

-- Observation:
-- 0 duplicate composite primary keys exist.


-- -----------------------------------------------------
-- 5. Check Blank Payment Types
-- -----------------------------------------------------

SELECT COUNT(*) AS blank_payment_type
FROM order_payments
WHERE TRIM(payment_type) = '';

-- Observation:
-- 0 number of blank payment types.


-- -----------------------------------------------------
-- 6. Payment Type Distribution
-- -----------------------------------------------------

SELECT
payment_type,
COUNT(*) AS total_transactions
FROM order_payments
GROUP BY payment_type
ORDER BY total_transactions DESC;

-- Observation:
-- the distribution of payment methods ia valid.


-- -----------------------------------------------------
-- 7. Check Payment Installments
-- -----------------------------------------------------

SELECT
MIN(payment_installments) AS min_installments,
MAX(payment_installments) AS max_installments,
ROUND(AVG(payment_installments),2) AS avg_installments
FROM order_payments;

-- Observation:
--  installment values are reasonable max 24, min 0 and average 2.85.


-- -----------------------------------------------------
-- 8. Check Invalid Installments
-- -----------------------------------------------------

SELECT COUNT(*) AS invalid_installments
FROM order_payments
WHERE payment_installments < 0;

-- Observation:
-- 0 negative installment values exist.


-- -----------------------------------------------------
-- 9. Check Invalid Payment Values
-- -----------------------------------------------------

SELECT COUNT(*) AS invalid_payment_value
FROM order_payments
WHERE payment_value < 0;

-- Observation:
-- 0 negative payment values exist.


-- -----------------------------------------------------
-- 10. Check Referential Integrity
-- -----------------------------------------------------

SELECT COUNT(*) AS missing_orders
FROM order_payments op
LEFT JOIN orders o
ON op.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Observation:
-- 0 number of missing order references.


-- =====================================================
-- Final Observation
-- =====================================================
-- The order_payments table has been successfully validated.
-- All 103,886 records were imported correctly.
-- No NULL values were found in any mandatory column.
-- No duplicate composite primary key values
-- (order_id, payment_sequential) were detected.
-- No blank payment_type values were found.
-- Payment installment values are valid, ranging from
-- 0 to 24, with an average of 2.85 installments.
-- No negative installment or payment values were identified.
-- The distribution of payment methods is valid and
-- consistent with the original dataset.
-- Referential integrity with the orders table is fully
-- maintained, with no missing foreign key references.
-- Overall, the table is clean, internally consistent,
-- and ready for analysis without requiring any data cleaning.




-- =====================================================
-- ORDER_REVIEWS TABLE DATA QUALITY CHECKS
-- =====================================================

-- -----------------------------------------------------
-- 1. Check Total Number of Rows
-- -----------------------------------------------------

SELECT COUNT(*) AS total_rows
FROM order_reviews;


-- Observation:
-- Total records imported: 99,224.
-- The row count matches the original dataset.


-- -----------------------------------------------------
-- 2. Preview First 10 Rows
-- -----------------------------------------------------

SELECT *
FROM order_reviews
LIMIT 10;

-- Observation:
-- The data is correctly imported, and all columns are displayed as expected.


-- -----------------------------------------------------
-- 3. Check NULL Values
-- -----------------------------------------------------

SELECT
SUM(CASE WHEN review_id IS NULL THEN 1 ELSE 0 END) AS review_id_null,
SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS order_id_null,
SUM(CASE WHEN review_score IS NULL THEN 1 ELSE 0 END) AS review_score_null,
SUM(CASE WHEN review_comment_title IS NULL THEN 1 ELSE 0 END) AS review_comment_title_null,
SUM(CASE WHEN review_comment_message IS NULL THEN 1 ELSE 0 END) AS review_comment_message_null,
SUM(CASE WHEN review_creation_date IS NULL THEN 1 ELSE 0 END) AS review_creation_date_null,
SUM(CASE WHEN review_answer_timestamp IS NULL THEN 1 ELSE 0 END) AS review_answer_timestamp_null
FROM order_reviews;

-- Observation:
-- review_comment_title contains 87,656 NULL values.
-- review_comment_message contains 58,247 NULL values.
-- No NULL values were found in the remaining mandatory columns.


-- -----------------------------------------------------
-- 4. Check Duplicate Review IDs
-- -----------------------------------------------------

SELECT
review_id,
COUNT(*)
FROM order_reviews
GROUP BY review_id
HAVING COUNT(*) > 1;

-- Observation:
-- Duplicate review_id values exist in the original dataset.
-- Therefore, review_id is intentionally not defined as the
-- primary key.


-- -----------------------------------------------------
-- 5. Check Blank Review IDs
-- -----------------------------------------------------

SELECT COUNT(*) AS blank_review_id
FROM order_reviews
WHERE TRIM(review_id) = '';

-- Observation:
-- No blank review_id values were found.


-- -----------------------------------------------------
-- 6. Check Blank Order IDs
-- -----------------------------------------------------

SELECT COUNT(*) AS blank_order_id
FROM order_reviews
WHERE TRIM(order_id) = '';

-- Observation:
-- No blank order_id values were found.


-- -----------------------------------------------------
-- 7. Review Score Distribution
-- -----------------------------------------------------

SELECT
review_score,
COUNT(*) AS total_reviews
FROM order_reviews
GROUP BY review_score
ORDER BY review_score;

-- Observation:
-- Review scores are distributed between 1 and 5 as expected.


-- -----------------------------------------------------
-- 8. Check Invalid Review Scores
-- -----------------------------------------------------

SELECT COUNT(*) AS invalid_review_scores
FROM order_reviews
WHERE review_score NOT BETWEEN 1 AND 5;

-- Observation:
-- No invalid review scores were found.


-- -----------------------------------------------------
-- 9. Check Referential Integrity
-- -----------------------------------------------------

SELECT COUNT(*) AS missing_orders
FROM order_reviews r
LEFT JOIN orders o
ON r.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Observation:
-- No missing order references were found.


-- =====================================================
-- Final Observation
-- =====================================================

-- The order_reviews table has been successfully validated.
-- All 99,224 records were imported correctly.
-- No NULL values were found in the mandatory columns.
-- A total of 87,656 review titles and 58,247 review
-- messages are missing. These are expected because
-- providing written feedback is optional.
-- Duplicate review_id values exist in the original
-- dataset; therefore, review_id is intentionally not
-- defined as the primary key.
-- Review scores are valid and restricted to the range
-- of 1 to 5, with no invalid values identified.
-- Referential integrity with the orders table is fully
-- maintained, with no missing foreign key references.
-- Overall, the table is clean, internally consistent,
-- and ready for analysis without requiring any data
-- cleaning.


-- =====================================================
-- GEOLOCATION TABLE DATA QUALITY CHECKS
-- =====================================================

-- -----------------------------------------------------
-- 1. Check Total Number of Rows
-- -----------------------------------------------------

SELECT COUNT(*) AS total_rows
FROM geolocation;

-- Observation:
-- Total records imported: 1,000,163.
-- The row count matches the original dataset.


-- -----------------------------------------------------
-- 2. Preview First 10 Rows
-- -----------------------------------------------------

SELECT *
FROM geolocation
LIMIT 10;

-- Observation:
-- The data is correctly imported, and all columns are displayed as expected.


-- -----------------------------------------------------
-- 3. Check NULL Values
-- -----------------------------------------------------

SELECT
SUM(CASE WHEN geolocation_zip_code_prefix IS NULL THEN 1 ELSE 0 END) AS zip_code_null,
SUM(CASE WHEN geolocation_lat IS NULL THEN 1 ELSE 0 END) AS latitude_null,
SUM(CASE WHEN geolocation_lng IS NULL THEN 1 ELSE 0 END) AS longitude_null,
SUM(CASE WHEN geolocation_city IS NULL THEN 1 ELSE 0 END) AS city_null,
SUM(CASE WHEN geolocation_state IS NULL THEN 1 ELSE 0 END) AS state_null
FROM geolocation;

-- Observation:
-- Record the NULL count returned by the query.


-- -----------------------------------------------------
-- 4. Check Blank City Names
-- -----------------------------------------------------

SELECT COUNT(*) AS blank_city
FROM geolocation
WHERE TRIM(geolocation_city) = '';

-- Observation:
-- 0 number of blank city names.


-- -----------------------------------------------------
-- 5. Check Blank State Codes
-- -----------------------------------------------------

SELECT COUNT(*) AS blank_state
FROM geolocation
WHERE TRIM(geolocation_state) = '';

-- Observation:
--0 number of blank state codes.


-- -----------------------------------------------------
-- 6. Check Duplicate Records
-- -----------------------------------------------------

SELECT
geolocation_zip_code_prefix,
geolocation_lat,
geolocation_lng,
geolocation_city,
geolocation_state,
COUNT(*)
FROM geolocation
GROUP BY
geolocation_zip_code_prefix,
geolocation_lat,
geolocation_lng,
geolocation_city,
geolocation_state
HAVING COUNT(*) > 1;

-- Observation:
--  number of duplicate records is available


-- -----------------------------------------------------
-- 7. Check Distinct States
-- -----------------------------------------------------

SELECT
geolocation_state,
COUNT(*) AS total_locations
FROM geolocation
GROUP BY geolocation_state
ORDER BY total_locations DESC;

-- Observation:
--  all state codes are valid.


-- -----------------------------------------------------
-- 8. Check Latitude & Longitude Range
-- -----------------------------------------------------

SELECT
MIN(geolocation_lat) AS min_latitude,
MAX(geolocation_lat) AS max_latitude,
MIN(geolocation_lng) AS min_longitude,
MAX(geolocation_lng) AS max_longitude
FROM geolocation;

-- Observation:
--  latitude values lie between -90 and 90,
-- and longitude values lie between -180 and 180.


-- -----------------------------------------------------
-- 9. Check Invalid Coordinates
-- -----------------------------------------------------

SELECT COUNT(*) AS invalid_coordinates
FROM geolocation
WHERE geolocation_lat NOT BETWEEN -90 AND 90
   OR geolocation_lng NOT BETWEEN -180 AND 180;

-- Observation:
-- 0 number of invalid coordinates.


-- -----------------------------------------------------
-- 10. Check Numeric City Names
-- -----------------------------------------------------

SELECT *
FROM geolocation
WHERE geolocation_city ~ '^[0-9]+$';

-- Observation:
-- No city names contain only numeric values.


-- =====================================================
-- Final Observation
-- =====================================================

-- Complete after reviewing the query results.



-- =====================================================
-- Final Observation
-- =====================================================
-- The geolocation table has been successfully validated.
-- All 1,000,163 records were imported correctly.
-- No NULL values or blank entries were found in any column.
-- All state codes are valid, and all latitude and longitude
-- values fall within their expected geographic ranges.
-- No invalid coordinate values or numeric-only city names
-- were identified.
-- Duplicate records are present in the dataset. These
-- duplicates originate from the original Olist dataset,
-- where multiple records may share the same ZIP code prefix
-- and geographic coordinates. Therefore, they have been
-- retained in the raw dataset.
-- Overall, the table is internally consistent and suitable
-- for analysis, with duplicate records representing the
-- only documented data quality characteristic of the
-- original dataset.




-- =====================================================
-- PRODUCT_CATEGORY_TRANSLATION TABLE DATA QUALITY CHECKS
-- =====================================================

-- -----------------------------------------------------
-- 1. Check Total Number of Rows
-- -----------------------------------------------------

SELECT COUNT(*) AS total_rows
FROM product_category_translation;

-- Observation:
-- Total records imported: 71.
-- The row count matches the original dataset.


-- -----------------------------------------------------
-- 2. Preview First 10 Rows
-- -----------------------------------------------------

SELECT *
FROM product_category_translation
LIMIT 10;

-- Observation:
-- The data is correctly imported, and all columns are displayed as expected.


-- -----------------------------------------------------
-- 3. Check NULL Values
-- -----------------------------------------------------

SELECT
SUM(CASE WHEN product_category_name IS NULL THEN 1 ELSE 0 END) AS category_name_null,
SUM(CASE WHEN product_category_name_english IS NULL THEN 1 ELSE 0 END) AS category_name_english_null
FROM product_category_translation;

-- Observation:
-- 0 NULL count returned by the query.


-- -----------------------------------------------------
-- 4. Check Duplicate Category Names
-- -----------------------------------------------------

SELECT
product_category_name,
COUNT(*)
FROM product_category_translation
GROUP BY product_category_name
HAVING COUNT(*) > 1;

-- Observation:
-- 0 duplicate Portuguese category names exist.


-- -----------------------------------------------------
-- 5. Check Duplicate English Category Names
-- -----------------------------------------------------

SELECT
product_category_name_english,
COUNT(*)
FROM product_category_translation
GROUP BY product_category_name_english
HAVING COUNT(*) > 1;

-- Observation:
-- 0 duplicate English category names exist.


-- -----------------------------------------------------
-- 6. Check Blank Portuguese Category Names
-- -----------------------------------------------------

SELECT COUNT(*) AS blank_category_name
FROM product_category_translation
WHERE TRIM(product_category_name) = '';

-- Observation:
-- 0 number of blank category names.


-- -----------------------------------------------------
-- 7. Check Blank English Category Names
-- -----------------------------------------------------

SELECT COUNT(*) AS blank_category_name_english
FROM product_category_translation
WHERE TRIM(product_category_name_english) = '';

-- Observation:
-- 0 number of blank English category names.


-- -----------------------------------------------------
-- 8. Check Category Name Length
-- -----------------------------------------------------

SELECT
MIN(LENGTH(product_category_name)) AS min_portuguese_length,
MAX(LENGTH(product_category_name)) AS max_portuguese_length,
MIN(LENGTH(product_category_name_english)) AS min_english_length,
MAX(LENGTH(product_category_name_english)) AS max_english_length
FROM product_category_translation;

-- Observation:
--  category names have reasonable lengths.


-- =====================================================
-- Final Observation
-- =====================================================
-- The product_category_translation table has been
-- successfully validated.
-- All 71 records were imported correctly.
-- No NULL values were found in any column.
-- No duplicate Portuguese or English category names
-- were detected.
-- No blank category names were found in either the
-- Portuguese or English columns.
-- All category names have reasonable lengths,
-- indicating consistent and well-formatted data.
-- Overall, the table is clean, internally consistent,
-- and ready for analysis without requiring any data
-- cleaning.







----------------------------------------------------------------

-- =====================================================
-- OVERALL DATA QUALITY ASSESSMENT
-- =====================================================

-- The Olist database consists of nine tables, all of which
-- were successfully imported and validated.

-- Customers:
-- No data quality issues were identified. The table is clean
-- and ready for analysis without requiring any modifications.

-- Orders:
-- The table is structurally consistent. NULL values in delivery-
-- related columns are expected for cancelled or undelivered
-- orders and do not require data cleaning.

-- Products:
-- This table requires additional investigation. Missing product
-- attributes, products with zero weight, and unmatched category
-- translations were identified. These issues originate from the
-- original dataset and should be considered during data cleaning
-- or specific analyses.

-- Sellers:
-- The table is generally clean. Minor anomalies, such as
-- numeric-only city names, were identified in the original
-- dataset but do not significantly affect analysis.

-- Order_Items:
-- No data quality issues were identified. The table is clean
-- and ready for analysis.

-- Order_Payments:
-- The table is clean and internally consistent. Payment
-- installment values are reasonable, although a small number
-- of records contain zero installments and may be reviewed
-- if required for specific analyses.

-- Order_Reviews:
-- Duplicate review_id values and missing review titles/messages
-- are characteristics of the original dataset. These do not
-- affect referential integrity and require no modification.

-- Geolocation:
-- Duplicate geolocation records were identified. These are
-- expected in the original dataset and have been retained in
-- the raw data.

-- Product_Category_Translation:
-- No data quality issues were identified. The table is clean
-- and ready for analysis.

-- Overall Conclusion:
-- The Olist database is suitable for exploratory analysis and
-- business intelligence reporting. Most tables required no
-- modifications, while the Products table requires further
-- investigation before analyses involving product attributes,
-- dimensions, or category information.



