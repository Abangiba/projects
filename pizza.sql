SELECT * FROM pizza_sales.pizza_sale;
# total revenue 
SELECT SUM(total_price) total_revenue FROM pizza_sales.pizza_sale;
# average order value
SELECT SUM(total_price)/COUNT(DISTINCT order_id) Avg_order_value  FROM pizza_sales.pizza_sale;
#total pizza sold 

SELECT SUM(quantity) total_pizza_sold FROM pizza_sales.pizza_sale;
 # total orders
 SELECT COUNT(DISTINCT order_id) total_orders  FROM pizza_sales.pizza_sale;
 #average pizza per order
 SELECT SUM(quantity)/COUNT(DISTINCT order_id) FROM pizza_sales.pizza_sale;
 #daily trend of orders
 SELECT DATE_FORMAT(order_date, '02-01-2015') AS order_per_day, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales.pizza_sale
GROUP BY DATE_FORMAT(order_date, '02-01-2015');
SELECT DATE_FORMAT(STR_TO_DATE(order_date, '%m-%d-%y'), '%W') AS order_per_day,
       COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales.pizza_sale
GROUP BY DATE_FORMAT(STR_TO_DATE(order_date, '%m-%d-%y'), '%W') ;
SELECT DATE_FORMAT(STR_TO_DATE(order_date, '%m-%d-%y'), '%W') from  pizza_sales.pizza_sale;
select pizza_category,DATE(order_date) as okk 
 FROM  pizza_sales.pizza_sale
 where pizza_category <>1;
WHERE (order_date) between '01-01-2015' and '10-30-2015' orby order_date;
# highest orders by pizza size
SELECT SUM( quantity ), pizza_category, DENSE_RANK() OVER (Order by pizza_category )
FROM  pizza_sales.pizza_sale GROUP BY pizza_category LIMIT 5;
SELECT pizza_category,sum(quantity) ,dense_rank() over ( order by pizza_category) 
from pizza_sales.pizza_sale
GROUP BY pizza_category;
# top pizza orders by category
SELECT sum(quantity), pizza_category as top_pizza_orders_category from  pizza_sales.pizza_sale
group by pizza_category;
# hourly trends for total orders
SELECT HOUR(order_time) AS order_hours,COUNT(DISTINCT order_id)AS total_orders 
FROM   pizza_sales.pizza_sale
GROUP BY HOUR(order_time)
ORDER BY HOUR(order_time);
#Percentage of sales by pizza category
SELECT pizza_category, SUM(total_price) * 100 / (SELECT SUM(total_price)  FROM pizza_sales.pizza_sale) AS PCT
FROM pizza_sales.pizza_sale
GROUP BY pizza_category;
#percentage of sales by pizza size
SELECT pizza_size, SUM(total_price) * 100 / (SELECT SUM(total_price)  FROM pizza_sales.pizza_sale) AS PCT
FROM pizza_sales.pizza_sale
GROUP BY pizza_size
ORDER BY pizza_size;

#total pizza sold by pizza category
SELECT pizza_category,SUM(quantity) AS total_pizza_sold
 FROM pizza_sales.pizza_sale
 GROUP BY pizza_category;
 #top 5 best sellers by total pizza sold 
 SELECT pizza_name,sum(quantity) AS total_pizza_sold
 FROM pizza_sales.pizza_sale
 GROUP BY pizza_name
 ORDER BY SUM(quantity) desc
 LIMIT 5; 
 
 SELECT * FROM pizza_sales.pizza_sale;

SELECT pizza_size, AS total_sales CAST(SUM(total_price) * 100 / (SELECT SUM(total_price)  FROM pizza_sales.pizza_sale) AS DECIMAL (10,2) AS PCT
FROM pizza_sales.pizza_sale
GROUP BY pizza_size
ORDER BY pizza size;



 