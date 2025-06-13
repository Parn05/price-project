CREATE DATABASE sales_analysis_project;

USE sales_analysis_project;

CREATE TABLE retail_price 
(
  product_id VARCHAR(25),
  product_category_name VARCHAR(25),
  month_year DATE,
  qty INT,
  total_revenue FLOAT,
  freight_price FLOAT,
  unit_price FLOAT,
  product_score FLOAT,
  customers INT,
  weekday INT,
  weekend INT,
  comp_1 FLOAT,
  ps1 FLOAT,
  comp_2 FLOAT,
  ps2 FLOAT,
  comp_3 FLOAT, 
  ps3 FLOAT
);

-- Total sales by month and year
SELECT DATE_FORMAT(month_year,'%b-%Y'),
 round(sum(total_revenue),2) AS total_sales
FROM retail_price
GROUP BY month_year
ORDER BY total_sales DESC;

-- Top 10 products by quantity sold
SELECT 
 product_id,
 sum(qty) AS total_quantity
FROM retail_price
GROUP BY product_id
ORDER BY total_quantity DESC
LIMIT 10;

-- Top 10 products by sales
SELECT 
 product_id,
 round(sum(total_revenue),2) AS total_sales
FROM retail_price
GROUP BY product_id
ORDER BY total_sales DESC
LIMIT 10;

-- Compare price with competitors
SELECT
 unit_price, 
 comp_1,
 comp_2,
 comp_3,
CASE
 WHEN unit_price > comp_1 THEN 'more expensive'
 WHEN unit_price < comp_1 THEN 'cheaper'
 ELSE 'same price'
END AS comp1_comparison,
CASE
 WHEN unit_price > comp_2 THEN 'more expensive'
 WHEN unit_price < comp_2 THEN 'cheaper'
 ELSE 'same price'
END AS comp2_comparison,
CASE
 WHEN unit_price > comp_3 THEN 'more expensive'
 WHEN unit_price < comp_3 THEN 'cheaper'
 ELSE 'same price'
END AS comp3_comparison
FROM retail_price;

-- Average product score by product ID
SELECT 
 product_id,
 round(AVG(product_score),3) AS avg_score
FROM retail_price
GROUP BY product_id
ORDER BY avg_score DESC;

-- Average product score by product category
SELECT 
 product_category_name,
 round(AVG(product_score),3) AS avg_score
FROM retail_price
GROUP BY product_category_name
ORDER BY avg_score DESC;

-- Freight cost as percentage of unit cost
SELECT
 product_id,  
 AVG(freight_price) as avg_freight,
 AVG(unit_price) as avg_unit,
 (AVG(freight_price) / AVG(unit_price))*100 AS freight_pct
FROM retail_price
GROUP BY product_id;