USE pizza_DB;
SELECT * FROM pizza_sales;
-- Daily Trend
SELECT DATENAME(DW, order_date) AS order_day, count(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date);

-- Hourly Trend
 SELECT DATEPART(HOUR, order_time) AS order_hours, count(DISTINCT order_id) AS Total_orders
 FROM pizza_sales
 GROUP BY DATEPART(HOUR, order_time)
 ORDER BY DATEPART(HOUR, order_time)

 -- Percentage of Sales by Pizza Category
 SELECT pizza_category, sum(total_price) AS Total_Sales, sum(total_price) * 100 / 
 (SELECT sum(total_price) FROM pizza_sales) AS PCT
 FROM pizza_sales 
 WHERE MONTH(order_date) = 1
 GROUP BY pizza_category;

 -- Pizza size
 SELECT pizza_size, CAST(sum(total_price) AS DECIMAL(10, 2)) AS Total_Sales, CAST(sum(total_price) * 100 / 
 (SELECT sum(total_price) FROM pizza_sales WHERE DATEPART (QUARTER, order_date)=1) AS DECIMAL(10,2)) AS PCT
 FROM pizza_sales 
 WHERE DATEPART (QUARTER, order_date)=1
 GROUP BY pizza_size
 ORDER BY PCT DESC;

 -- Total Sold Pizza By Category
 SELECT pizza_category, SUM (quantity) AS Total_Pizzs_Sold
 FROM pizza_sales
 GROUP BY pizza_category;

 -- Top 5 Best Seller
 SELECT TOP 5 pizza_name, sum(quantity) AS Total_Pizza_Sold
 FROM pizza_sales
 GROUP BY pizza_name
 ORDER BY sum(quantity) DESC;

 -- Top 5 Worst Seller
 SELECT TOP 5 pizza_name, sum(quantity) AS Total_Pizza_Sold
 FROM pizza_sales
 WHERE MONTH(order_date) = 1
 GROUP BY pizza_name
 ORDER BY sum(quantity) ASC;