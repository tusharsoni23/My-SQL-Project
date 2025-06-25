create database project;
use project;

select * from superstore;

show columns from superstore;

-- Retreive all the records of superstore data
select * from superstore;

-- Number of rows
select count(*) from superstore;

-- get the unique ship Mode >> similar to unique value in pandas
show columns from superstore;

select distinct `Ship Mode` from superstore;

-- count how many orders were placed
select count(distinct `Order ID`) from superstore;

-- Show total sales per category
select Category, SUM(Sales) as total_sales 
from superstore
group by Category;

-- List all customers from California
SELECT DISTINCT `Customer Name` FROM superstore WHERE State = 'California';

 -- Find the total no of unique customers
SELECT COUNT(DISTINCT `Customer ID`) AS unique_customers FROM superstore;

-- what is the total profit for the 'Chairs' sub-category
SELECT SUM(Profit) AS total_profit FROM superstore WHERE `Sub-Category` = 'Chairs';


-- Show top 5 products by sales.
SELECT `Product Name`, SUM(Sales) AS Total_Sales
FROM Superstore
GROUP BY `Product Name`
ORDER BY Total_Sales DESC
LIMIT 5;

-- Find the earliest and latest order date
SELECT 
    min(`Order Date`) AS Earliest_Order_Date,
    MAX(`Order Date`) AS Latest_Order_Date
from  Superstore;

-- Average discount per region
select Region, AVG(Discount) as avg_discount 
from superstore 
group by Region;

-- state with highest total sales
SELECT State, SUM(Sales) AS total_sales 
FROM superstore 
GROUP BY State 
ORDER BY total_sales DESC 
LIMIT 1;


-- Total quantity of products sold per sub-category
SELECT `Sub-Category`, SUM(Quantity) AS total_quantity 
FROM superstore 
GROUP BY `Sub-Category`;

-- List customers with more than 2 order
SELECT `Customer ID`, `Customer Name`, COUNT(DISTINCT `Order ID`) AS orders 
FROM superstore 
GROUP BY `Customer ID`, `Customer Name` 
HAVING orders > 2;



-- Number of orders shipped using `Second Class`
SELECT COUNT(DISTINCT `Order ID`) AS second_class_orders 
FROM superstore 
WHERE `Ship Mode` = 'Second Class';

-- Top 3 sub categories by profit in each category

select *
from (
select Category, `Sub-Category`, SUM(Profit) as total_profits,
RANK() OVER (PARTITION BY  Category ORDER BY SUM(Profit) Desc) as rk
from superstore
group by Category, `Sub-Category`)
as ranked_subs
where rk <= 3;


-- Find orders with negative profit
SELECT `Order ID`, `Product Name`, Profit 
FROM superstore 
WHERE Profit < 0;

-- Cities where more than 10000 of sales happened
select city, sum(sales) as city_sales
from superstore
group by City
Having city_sales > 10000;

-- Find the products with zero profit but non zero sales
SELECT `Product Name`, Sales, Profit 
FROM superstore 
WHERE Profit = 0 AND Sales > 0;

 -- Sub-categories where discount was always 0.
select `Sub-Category`
from superstore
Group by `Sub-Category`
Having Max(Discount)=0;

-- Rank customers by Profit in each region
SELECT * FROM (
  SELECT Region, `Customer Name`, SUM(Profit) AS total_profit,
         RANK() OVER (PARTITION BY Region ORDER BY SUM(Profit) DESC) AS rk
  FROM superstore
  GROUP BY Region, `Customer Name`
) AS region_customers;

-- Which states have the lowest average sales per order?
SELECT State, AVG(sales_order) AS avg_sales
FROM (
  SELECT State, `Order ID`, SUM(Sales) AS sales_order
  FROM superstore
  GROUP BY State, `Order ID`
) AS state_sales
GROUP BY State
ORDER BY avg_sales ASC;
-- Write a CTE to find most profitable product in each sub-category.
WITH product_profit AS (
  SELECT `Sub-Category`, `Product Name`, SUM(Profit) AS total_profit,
         RANK() OVER (PARTITION BY `Sub-Category` ORDER BY SUM(Profit) DESC) AS rk
  FROM superstore
  GROUP BY `Sub-Category`, `Product Name`
)
SELECT * FROM product_profit WHERE rk = 1;











