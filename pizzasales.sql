create database pizza_sales;
use pizza_sales;
SELECT * from pizza_sales.ps;
desc pizza_sales.ps;

alter table pizza_sales.ps modify column unit_price float;
alter table pizza_sales.ps modify column total_price float;


#1.total revenue earned 
select sum(total_price) as total_revenue from ps;

#2. avg order value
select sum(total_price)/count(distinct order_id)  as avg_order_value from ps;

#3.Total pizzas sold 
select sum(quantity) as total_pizza_sold from ps;

#4.Total order placed
select count(distinct order_id) as total_order_placed from ps;

#5.Avg pizza per order
select sum(quantity)/count(distinct order_id)as avg_pizza_perorder from ps;
-------------

#6.Daily trend for pizza order
SELECT 
    DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_day,
    COUNT(DISTINCT order_id) AS Total_orders
FROM 
    ps
GROUP BY 
    DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y'))
ORDER BY 
    CASE 
        WHEN DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) = 'Monday' THEN 1
        WHEN DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) = 'Tuesday' THEN 2
        WHEN DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) = 'Wednesday' THEN 3
        WHEN DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) = 'Thursday' THEN 4
        WHEN DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) = 'Friday' THEN 5
        WHEN DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) = 'Saturday' THEN 6
        WHEN DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) = 'Sunday' THEN 7
    END;
    
#7.Hourly Trend for pizza order
select hour(order_time) as order_hours,
COUNT(DISTINCT order_id) AS Total_orders
from ps 
group by hour(order_time) 
order by hour(order_time);

#8.percentage of sale by pizza category
select pizza_category,sum(total_price) as total_sales,
sum(total_price)*100/(select sum(total_price) from ps) as PCT
from ps group by pizza_category;


#9. percentage of sale by pizza size
select pizza_size,cast(sum(total_price) as decimal(10,2)) as total_sales,
cast(sum(total_price)*100/(select sum(total_price) from ps)as decimal (10,2)) as PCT
from ps group by pizza_size order by pct desc;


#10.total pizza sold by category
select pizza_category,sum(quantity) as total_pizza_sold from ps
group by pizza_category;

#11. top 5 bestsellers pizza sold
SELECT pizza_name, sum(quantity) as Total_Pizzas_Sold
from ps Group by pizza_name ORDER BY sum(quantity) DESC
LIMIT 5;

#12.Bottom 5 pizza sold
SELECT pizza_name, sum(quantity) as Total_Pizzas_Sold
from ps Group by pizza_name ORDER BY sum(quantity) asc
limit 5;


