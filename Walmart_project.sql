------- Create A DATABASE SALESDATAWALMART------------------



create database if not exists salesdatawalmart;

create table if not exists sales(
 invoice_id varchar(30) not null primary key,
 branch varchar(5) not null, 
 city varchar(30) not null,
 customer_type varchar(30) not null,
 gender varchar (10) NOT NULL,
 product_line varchar(100) not null,
 unit_price decimal(10,2) not null,
 quantity int not null,
 vat decimal (6,4) not null,
 total decimal (12,4) not null,
 Date datetime not null,
 time TIME not null,
 payment_method varchar(15) not null,
 cogs decimal (10,2) not null,
 gross_margin_percentage decimal(11,9) not null,
 gross_income decimal (12,4) not null,
 rating decimal(2,1)
 );

 SELECT * FROM salesdatawalmart.sales;

-- -- Feature Engineering -- --

-- Add a new column named time_of_day to give insight of sales in the Morning, Afternoon and Evening.

SELECT 
    time,
    (CASE
        WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END) AS 'time_of_day'
FROM
    sales;
Alter Table sales add column time_of_day varchar(20);

set Sql_safe_updates = 0;

UPDATE sales 
SET 
    time_of_day = (CASE
        WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END);


-- -- Feature Engineering -- --

-- Add a new column named day_name that contains the extracted days of the week 
-- on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). 

SELECT 
    date, DAYNAME(date) AS day_name
FROM
    sales;
    
    
Alter table sales add column day_name varchar(10);


UPDATE sales 
SET 
    day_name = DAYNAME(date);


-- -- Feature Engineering -- --

-- Add a new column named month_name 
-- that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). 

SELECT 
    date, MONTHNAME(date) AS month_name
FROM
    sales;

alter table sales add column month_name varchar (20);

UPDATE sales 
SET 
    month_name = MONTHNAME(date);


-- ------------------------------------------Generic Questions----------------------------------------------------------------

-- How many unique cities does the data have?--

SELECT DISTINCT
    city
FROM
    sales;

-- In which city is each branch?--


SELECT DISTINCT
    city, branch
FROM
    sales;



----------------------------------------- Product related questions ------------------------------------------

-- How many unique product lines does the data have?

SELECT DISTINCT
    product_line
FROM
    sales;

-- What is the most common payment method?

SELECT 
    payment_method, COUNT(*)
FROM
    sales
GROUP BY payment_method
ORDER BY payment_method DESC;

-- What is the most selling product line?

SELECT 
    product_line, COUNT(*) AS quantity
FROM
    sales
GROUP BY product_line
ORDER BY quantity DESC;

-- What is the total revenue by month?

SELECT 
    month_name AS month, SUM(total) AS total_revenue
FROM
    sales
GROUP BY month_name
ORDER BY total_revenue;

-- What month had the largest COGS?

SELECT 
    month_name, MAX(cogs) AS Cogs
FROM
    sales
GROUP BY month_name
ORDER BY cogs desc;

-- What product line had the largest revenue?

SELECT 
    product_line, SUM(total) AS revenue
FROM
    sales
GROUP BY product_line
ORDER BY revenue DESC;

-- What is the city with the largest revenue?

SELECT 
    branch, city, SUM(total) AS revenue
FROM
    sales
GROUP BY city , branch
ORDER BY revenue DESC;

-- What product line had the largest VAT?

SELECT 
    product_line, AVG(vat) AS vat
FROM
    sales
GROUP BY product_line
ORDER BY vat DESC;

-- Which branch sold more products than average product sold?

SELECT 
    branch, SUM(quantity) AS qty
FROM
    sales
GROUP BY branch
HAVING SUM(quantity) > AVG(quantity);

-- What is the most common product line by gender?

SELECT 
    product_line, gender, COUNT(gender) AS gender
FROM
    sales
GROUP BY product_line , gender
ORDER BY gender DESC
LIMIT 1;

-- What is the average rating of each product line?

SELECT 
    product_line, ROUND(avg(rating), 2) AS avg_rating
FROM
    sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- Fetch each product line and add a column to those product line showing "Good", "Bad". 
-- Good if its greater than average sales

SELECT 
    product_line,
    ROUND(AVG(total), 2) AS avg_rating,
    CASE
        WHEN
            ROUND(AVG(total), 2) > (SELECT 
                    AVG(total)
                FROM
                    sales)
        THEN
            'good'
        ELSE 'bad'
    END AS performance
FROM
    sales
GROUP BY product_line
ORDER BY avg_rating;



-- ----------------------------------- SALES RELATED QUESTIONS -- -------------------------------------

--- Number of sales made in each time of the day per weekday?

SELECT 
    time_of_day, day_name, COUNT(*) AS total_sales
FROM
    sales
GROUP BY time_of_day , day_name
ORDER BY total_sales DESC;

--- Which of the customer types brings the most revenue?

SELECT 
    customer_type, SUM(total) AS revenue
FROM
    sales
GROUP BY customer_type
ORDER BY revenue DESC;

--- Which city has the largest tax percent/ VAT (Value Added Tax)?

SELECT 
    city, AVG(vat) AS vat
FROM
    sales
GROUP BY city
ORDER BY vat DESC;

--- Which customer type pays the most in VAT?

SELECT 
    customer_type, AVG(vat) AS vat
FROM
    sales
GROUP BY customer_type
ORDER BY vat DESC;



----- ------------------------------------------ CUSTOMERS RELATED QUESTIONS ------------------------------------- ----

-- How many unique customer types does the data have?
SELECT DISTINCT
    customer_type AS unique_customertype
FROM
    sales;

-- How many unique payment methods does the data have?

SELECT DISTINCT
    payment_method
FROM
    sales;

-- What is the most common customer type?

SELECT 
    customer_type, COUNT(*) AS cst
FROM
    sales
GROUP BY customer_type
ORDER BY cst DESC
LIMIT 1;

-- Which customer type buys the most?

select customer_type, sum(cogs) as pays
from sales
group by customer_type
order by pays desc
limit 1;

-- What is the gender of most of the customers?

select gender, count(*) as most
from sales
group by gender 
order by most desc
limit 1;

-- What is the gender distribution per branch?

select branch, gender, count(*) as gender_count
from sales
group by branch, gender
order by gender_count desc;

-- Which time of the day do customers give most ratings?

select time_of_day, count(rating) as rating_count
from sales
group by time_of_day
order by rating_count desc;

-- Which time of the day do customers give most ratings per branch?

select time_of_day,branch, count(rating) as rating_count
from sales
group by time_of_day, branch
order by rating_count desc;

-- Which day fo the week has the best avg ratings?

select day_name, avg(rating) as ratings
from sales
group by day_name
order by ratings desc;

-- Which day of the week has the best average ratings per branch?

select day_name,branch,avg(rating) as ratings_count
from sales
group by day_name,branch
order by ratings_count desc;