use analytics_db;

------------ Table Creation ------------
CREATE TABLE pizza_sales (
    pizza_id          INTEGER PRIMARY KEY,
    order_id          INTEGER NOT NULL,
    pizza_name_id     VARCHAR(30) NOT NULL,
    quantity          INTEGER NOT NULL,
    order_date        DATE NOT NULL,
    order_time        TIME NOT NULL,
    unit_price        NUMERIC(6,2) NOT NULL,
    total_price       NUMERIC(8,2) NOT NULL,
    pizza_size        VARCHAR(5) NOT NULL,
    pizza_category    VARCHAR(20) NOT NULL,
    pizza_ingredients VARCHAR(200),
    pizza_name        VARCHAR(60) NOT NULL
);

#Pizza Sales Table structure
desc pizza_sales;

#Check the data imported properly
select * from pizza_sales limit 10;

#As per our requirements we doesnt require pizza_ingredients column, so we can remove that column from pizza_sales table
alter table pizza_sales drop column pizza_ingredients;

------------ Data Exploration ------------
#Modified pizza sales table
select * from pizza_sales;

#Identify Number of rows in table
select count(pizza_id)
from pizza_sales;

#Identify the Null Values in the table
select count(*) 
from pizza_sales
where pizza_id is null;


------------ Data Analysis ------------
---- Level 1: Basic totals ----
# 1. What is the total revenue?
select sum(total_price) as "Total_Revenue" 
from pizza_sales;

# 2. How many orders were placed?
select count(distinct order_id) as "Total_orders"
from pizza_sales;

# 3. How many pizzas were sold in total?
select count(distinct order_id) as "Total_orders", sum(total_price) as "Total_Revenue" 
from pizza_sales;

# 4. What is the average order value?
select (sum(total_price)/count(distinct order_id)) as "Average_Order_Value"
from pizza_sales;

# 5. How many pizzas are there in an average order?
select avg(quantity) as "Pizzas_Average_Order"
from(
select order_id,sum(quantity) as "Quantity"
from pizza_sales
group by order_id
order by Quantity
) t;

---- Level 2: Sales by group ----
# 1. How much revenue does each pizza category bring?
select pizza_category as "Pizza_Category", sum(total_price) as "Revenue"
from pizza_sales
group by Pizza_Category
order by Revenue desc;

# 2. How much revenue does each pizza size bring?
select pizza_size as "Size", sum(total_price) as "Revenue"
from pizza_sales
group by Size
order by Revenue desc;

# 3. What are the top 5 pizzas by revenue?
select distinct pizza_name as "Pizza", sum(total_price) as "Higest_Revenue"
from pizza_sales
group by Pizza
order by Higest_Revenue desc limit 5;

# 4. What are the bottom 5 pizzas by revenue?
select distinct pizza_name as "Pizza", sum(total_price) as "Higest_Revenue"
from pizza_sales
group by Pizza
order by Higest_Revenue asc limit 5;

# 5. What are the top 5 pizzas by quantity sold?
select pizza_name as "Pizza", count(quantity) as "Quantity"
from pizza_sales
group by Pizza 
order by Quantity desc limit 5;

# 6. What are the least 5 pizzas by quantity sold?
select pizza_name as "Pizza", count(quantity) as "Quantity"
from pizza_sales
group by Pizza 
order by Quantity asc limit 5;

---- Level 3: Time patterns ----
# 1. How much revenue is there in each month?
select month(order_date) as "Monthly", sum(total_price) as "Revenue"
from pizza_sales
group by Monthly
order by Revenue desc;

# 2. How many orders are there on each day of the week?
select week(order_date) as "Week_of_Each_Day", count(order_id) as "Orders"
from pizza_sales
group by Week_of_Each_Day
order by Orders desc;

# 4. How many orders are there in each hour of the day?
select hour(order_time) as "Hourly", count(distinct order_id) as "Total_Orders"
from pizza_sales
group by Hourly
order by Total_Orders desc;

# 5. Which are the busiest hours? 
select hour(order_time) as "Hourly", count(distinct order_id) as "Busiest_Hours"
from pizza_sales
group by Hourly
order by Busiest_Hours desc limit 5;

# 6. which are the quietest hours?
select hour(order_time) as "Hourly", count(distinct order_id) as "Quietest_Hours"
from pizza_sales
group by Hourly
order by Quietest_Hours asc limit 5;

----- Level 4: Percentages -----
# 1. What percentage of revenue comes from each category?
select pizza_category as "Category",
Round((sum(total_price)*100.0)/(select sum(total_price) from pizza_sales),2) as "Percent_of_Revenue"
from pizza_sales
group by Category
order by Percent_of_Revenue desc;

# 2. What percentage of revenue comes from each size?
select pizza_size as "Size",
Round((sum(total_price)*100.0)/(select sum(total_price) from pizza_sales),2) as "Percent_of_Revenue"
from pizza_sales
group by Size
order by Percent_of_Revenue desc;

# 3. How many orders have only 1 pizza, 2 pizzas, 3 pizzas and so on?
select Total_Quantity as "Quantity", count(*) as "Orders"
from
(select order_id, sum(quantity) as "Total_Quantity"
from pizza_sales
group by order_id) t
group by Total_Quantity;

# 4. What percentage of orders have just one pizza?
select 
round((sum(case when Quantity=1 then 1 else 0 end)*100.0)/count(*),2) as "Orders"
from
(select order_id, sum(quantity) as "Quantity" from pizza_sales group by order_id) t;


