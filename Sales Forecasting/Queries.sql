-- ============================================
-- Project: Retail Sales Analysis
-- Author: Vinayak
-- Description: End-to-end SQL analysis for retail sales dataset
-- ============================================

-- ===============================
-- 1. Create Table
-- ===============================
CREATE TABLE IF NOT EXISTS retail_sales (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    product VARCHAR(50),
    category VARCHAR(50),
    order_date DATE,
    quantity INT,
    price NUMERIC(10,2)
);

-- ===============================
-- 2. Insert Synthetic Data
-- ===============================
INSERT INTO retail_sales 
(customer_id, product, category, order_date, quantity, price)
SELECT
    (RANDOM()*300)::INT,
    (ARRAY['Laptop','Phone','Shoes','Watch','Bag'])[floor(random()*5 +1)],
    (ARRAY['Electronics','Fashion'])[floor(random()*2 +1)],
    CURRENT_DATE - (RANDOM()*365)::INT,
    (RANDOM()*5 +1)::INT,
    (RANDOM()*50000 + 500)::NUMERIC(10,2)
FROM generate_series(1,5000);

-- ===============================
-- 3. Data Preview
-- ===============================
SELECT * FROM retail_sales LIMIT 10;

-- ===============================
-- 4. Total Revenue
-- ===============================
SELECT 
    SUM(quantity * price) AS total_revenue
FROM retail_sales;

-- ===============================
-- 5. Category-wise Sales
-- ===============================
SELECT 
    category,
    SUM(quantity * price) AS total_sales
FROM retail_sales
GROUP BY category
ORDER BY total_sales DESC;

-- ===============================
-- 6. Top 5 Customers
-- ===============================
SELECT 
    customer_id,
    SUM(quantity * price) AS total_spent
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- ===============================
-- 7. Monthly Sales Trend
-- ===============================
SELECT 
    DATE_TRUNC('month', order_date) AS month,
    SUM(quantity * price) AS monthly_sales
FROM retail_sales
GROUP BY month
ORDER BY month;