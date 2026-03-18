-- =====================================================
-- SUPPLY CHAIN ANALYTICS PROJECT (SQL)
-- Author: Ajay T
-- Tools: MySQL
-- Dataset: Supply Chain Analysis Dataset
-- =====================================================

-- =====================================================
-- 1. DATABASE SETUP
-- =====================================================

CREATE DATABASE IF NOT EXISTS supply_chain_analytics;
USE supply_chain_analytics;

-- =====================================================
-- 2. DATA PREVIEW
-- View first rows of dataset
-- =====================================================

SELECT *
FROM supply_chain_data
LIMIT 10;

-- =====================================================
-- 3. TOTAL BUSINESS REVENUE
-- Calculates total revenue generated
-- =====================================================

SELECT
ROUND(SUM(`Revenue generated`),2) AS Total_Revenue
FROM supply_chain_data;

-- =====================================================
-- 4. TOTAL PRODUCTS SOLD
-- Total quantity of products sold
-- =====================================================

SELECT
SUM(`Number of products sold`) AS Total_Products_Sold
FROM supply_chain_data;

-- =====================================================
-- 5. REVENUE BY PRODUCT TYPE
-- Identify highest revenue generating products
-- =====================================================

SELECT
`Product type`,
ROUND(SUM(`Revenue generated`),2) AS Revenue
FROM supply_chain_data
GROUP BY `Product type`
ORDER BY Revenue DESC;

-- =====================================================
-- 6. SUPPLIER PERFORMANCE ANALYSIS
-- Determine suppliers contributing most revenue
-- =====================================================

SELECT
`Supplier name`,
ROUND(SUM(`Revenue generated`),2) AS Revenue
FROM supply_chain_data
GROUP BY `Supplier name`
ORDER BY Revenue DESC;

-- =====================================================
-- 7. SHIPPING PERFORMANCE
-- Analyze transportation efficiency
-- =====================================================

SELECT
`Transportation modes`,
ROUND(AVG(`Shipping times`),2) AS Avg_Shipping_Time
FROM supply_chain_data
GROUP BY `Transportation modes`;

-- =====================================================
-- 8. PRODUCT DEFECT RATE ANALYSIS
-- Identify products with highest defect rates
-- =====================================================

SELECT
`Product type`,
ROUND(AVG(`Defect rates`),2) AS Avg_Defect_Rate
FROM supply_chain_data
GROUP BY `Product type`
ORDER BY Avg_Defect_Rate DESC;

-- =====================================================
-- 9. INVENTORY ANALYSIS
-- Average stock levels by product
-- =====================================================

SELECT
`Product type`,
AVG(`Stock levels`) AS Avg_Stock_Level
FROM supply_chain_data
GROUP BY `Product type`;

-- =====================================================
-- 10. CREATE ANALYTICAL VIEW: PRODUCT PERFORMANCE
-- Used for Power BI product dashboard
-- =====================================================

CREATE VIEW product_performance AS
SELECT
`Product type`,
SUM(`Number of products sold`) AS total_products_sold,
ROUND(SUM(`Revenue generated`),2) AS total_revenue,
ROUND(AVG(`Defect rates`),2) AS avg_defect_rate,
AVG(`Stock levels`) AS avg_stock
FROM supply_chain_data
GROUP BY `Product type`;

-- =====================================================
-- 11. CREATE ANALYTICAL VIEW: SUPPLIER PERFORMANCE
-- Used for supplier analytics dashboard
-- =====================================================

CREATE VIEW supplier_performance AS
SELECT
`Supplier name`,
ROUND(SUM(`Revenue generated`),2) AS total_revenue,
AVG(`Lead time`) AS avg_lead_time,
ROUND(AVG(`Shipping costs`),2) AS avg_shipping_cost
FROM supply_chain_data
GROUP BY `Supplier name`;

-- =====================================================
-- 12. CREATE ANALYTICAL VIEW: LOGISTICS PERFORMANCE
-- Transportation analysis for Power BI
-- =====================================================

CREATE VIEW logistics_performance AS
SELECT
`Transportation modes`,
ROUND(AVG(`Shipping times`),2) AS avg_shipping_time,
ROUND(AVG(`Shipping costs`),2) AS avg_shipping_cost,
ROUND(SUM(`Revenue generated`),2) AS total_revenue
FROM supply_chain_data
GROUP BY `Transportation modes`;

-- =====================================================
-- 13. CREATE ANALYTICAL VIEW: LOCATION PERFORMANCE
-- Regional supply chain analysis
-- =====================================================

CREATE VIEW location_performance AS
SELECT
Location,
ROUND(SUM(`Revenue generated`),2) AS total_revenue,
AVG(`Stock levels`) AS avg_stock_level,
ROUND(AVG(`Defect rates`),2) AS avg_defect_rate
FROM supply_chain_data
GROUP BY Location;

SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';

-- =====================================================
-- END OF SQL ANALYSIS
-- =====================================================
