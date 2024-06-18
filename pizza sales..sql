USE PIZZAHUT;
DROP TABLE ORDERS;
SELECT * FROM ORDERS;

CREATE TABLE ORDERS(
ORDER_ID INT NOT NULL,
ORDER_DATE DATE NOT NULL,
ORDER_TIME TIME NOT NULL,
PRIMARY KEY(ORDER_ID));

CREATE TABLE ORDER_DETAILS(
ORDER_DETAILS_ID INT NOT NULL,
ORDER_ID INT NOT NULL,
PIZZA_ID TEXT NOT NULL,
QUANTITY INT NOT NULL,
PRIMARY KEY(ORDER_DETAILS_ID));



CREATE DATABASE PIZZAHUT;
-- Retrieve the total number of orders placed.

SELECT * FROM ORDERS;
SELECT COUNT(ORDER_ID)  AS TOTAL_ORDERS FROM ORDERS;


-- Identify the highest-priced pizza.

SELECT 
    pizza_types.NAME, pizzas.price
FROM
    pizza_types
        INNER JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(order_details.QUANTITY * pizzas.PRICE),
            2) AS TOTAL_SALES
FROM
    order_details
        JOIN
    PIZZAS ON pizzas.pizza_id = order_details.PIZZA_ID;
    
    
    -- Identify the most common pizza size ordered. 

SELECT 
    pizzas.size,
    COUNT(order_details.ORDER_DETAILS_ID) AS order_count
FROM
    pizzas
        INNER JOIN
    order_details ON pizzas.pizza_id = order_details.PIZZA_ID
GROUP BY pizzas.size
ORDER BY order_count desc
LIMIT 1;


-- List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pizza_types.name, SUM(order_details.QUANTITY) AS QUANTITY
FROM
    pizza_types
        INNER JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.PIZZA_ID = pizzas.pizza_id
GROUP BY pizza_typeS.name
ORDER BY QUANTITY DESC
LIMIT 5;


-- Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.PIZZA_ID = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;


-- Determine the distribution of orders by hour of the day.

select hour(order_time) as hour ,count(order_id)  as order_count from orders
group by hour(order_time);


-- Join relevant tables to find the category-wise distribution of pizzas

select category,count(name)
from pizza_types 
group by category;


-- Group the orders by date and calculate the average number of pizzas ordered per day.

select round(avg (quantity),0)as avg_pizza_ordered from 
(select orders.order_date,sum(order_details.quantity) as quantity
from orders
join order_details on
orders.ORDER_ID=order_details.order_id
group by orders.ORDER_DATE) as order_quantity;


-- Determine the top 3 most ordered pizza types based on revenue.

select pizza_types.name,
sum(order_details.quantity * pizzas.price) as revenue
from pizza_types join pizzas
on pizzas.pizza_type_id=pizza_types.pizza_type_id
join order_details
on order_details.PIZZA_ID=PIZZAS.PIZZA_ID
group by pizza_types.NAME  ORDER BY REVENUE DESC LIMIT 3;

