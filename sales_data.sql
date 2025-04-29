create database if not exists sales_data;
use sales_data;

CREATE TABLE online_sales (
    transaction_id INT PRIMARY KEY,
    date DATE,
    product_category VARCHAR(100),
    product_name VARCHAR(255),
    units_sold INT,
    unit_price DECIMAL(10,2),
    total_revenue DECIMAL(10,2),
    region VARCHAR(100),
    payment_method VARCHAR(50)
);
--  Extract Month from Order Date
SELECT EXTRACT(MONTH FROM date) AS order_month
FROM online_sales;
-- Group by Year and Month

SELECT
    EXTRACT(YEAR FROM date) AS order_year,
    EXTRACT(MONTH FROM date) AS order_month
FROM online_sales
GROUP BY order_year, order_month;

-- Calculate Total Revenue using SUM()

SELECT
    SUM(total_revenue) AS total_revenue
FROM online_sales;

-- Count Distinct Orders (Volume)
SELECT
    COUNT(DISTINCT transaction_id) AS total_order_volume
FROM online_sales;
--  Monthly Revenue and Volume

SELECT
    EXTRACT(YEAR FROM date) AS order_year,
    EXTRACT(MONTH FROM date) AS order_month,
    SUM(total_revenue) AS total_revenue,
    COUNT(DISTINCT transaction_id) AS total_order_volume
FROM online_sales
GROUP BY order_year, order_month
ORDER BY order_year, order_month;
-- Top Revenue-Generating Categories
SELECT
    product_category,
    SUM(total_revenue) AS total_revenue
FROM online_sales
GROUP BY product_category
ORDER BY total_revenue DESC;
-- Top 5 Best-Selling Products
SELECT
    product_name,
    SUM(total_revenue) AS total_revenue
FROM online_sales
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 5;
-- Limit Results for a Specific Time Period (March 2024)
SELECT
    EXTRACT(YEAR FROM date) AS order_year,
    EXTRACT(MONTH FROM date) AS order_month,
    SUM(total_revenue) AS total_revenue,
    COUNT(DISTINCT transaction_id) AS total_order_volume
FROM online_sales
WHERE date >= '2024-03-01' AND date < '2024-04-01'
GROUP BY order_year, order_month
ORDER BY order_year, order_month;

