Create database pizza_sales;
USE pizza_sales;
show tables;
SELECT * from pizza_sales;

-- total revenue
SELECT SUM(total_price) AS Total_revenue
FROM pizza_sales;

-- Average Order Value
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value FROM pizza_sales;


-- Total Pizza Sold
SELECT (SUM(quantity)) AS Total_pizza_sold FROM pizza_sales;

-- Total Orders placed
SELECT COUNT(DISTINCT order_id) AS Total_orders from  pizza_sales;
 
 --  Average Pizzas Per Order
 SELECT CAST(CAST(SUM(quantity) AS DECIMAL (10,2))/
 CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2))AS DECIMAL (10,2)) AS Average_Pizzas_Per_Order
 from pizza_sales;
 
 
 -- Daily Trend for Total Orders
SELECT
    order_date,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
WHERE order_date IS NOT NULL
GROUP BY order_date
ORDER BY order_date;

 -- Monthly Trend for Orders
 
SELECT
    MONTHNAME(order_date) AS month_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
WHERE order_date IS NOT NULL
GROUP BY
    MONTHNAME(order_date),
    MONTH(order_date)
ORDER BY
    MONTH(order_date);
    
SELECT
    MONTH(order_date) AS month_number,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date);
 
 -- % of Sales by Pizza Category
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category;

-- % of Sales by Pizza Size

SELECT
    pizza_size,
    ROUND(SUM(total_price), 2) AS total_revenue,
    ROUND(
        SUM(total_price) * 100.0 /
        (SELECT SUM(total_price) FROM pizza_sales),
        2
    ) AS pct_of_sales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY total_revenue DESC;

-- Total Pizzas Sold by Pizza Category
SELECT
    pizza_category,
    SUM(quantity) AS total_quantity_sold
FROM pizza_sales
WHERE MONTH(STR_TO_DATE(order_date, '%Y-%m-%d')) = 2
GROUP BY pizza_category
ORDER BY total_quantity_sold DESC;

-- Top 5 Pizzas by Revenue
SELECT 
    pizza_name,
    SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC
LIMIT 5;

-- Bottom 5 Pizzas by revenue

SELECT 
    pizza_name,
    SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue ASC
LIMIT 5;

-- Top 5 Pizzas by Quantity
SELECT  pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
LIMIT 5;

--  Bottom 5 Pizzas by Quantity

SELECT  pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
LIMIT 5;

--  Top 5 Pizzas by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
LIMIT 5;


--  Borrom 5 Pizzas by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC
LIMIT 5;

-- By Catogory
SELECT  pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
WHERE pizza_category = 'Classic'
GROUP BY pizza_name
ORDER BY Total_Orders ASC
LIMIT 5;


