--CREATE DATABASE Ecomm_DB;

--Check total rows
SELECT COUNT(*) FROM Sales_Data_Ecommerce
SELECT COUNT(*) FROM Promotion;

SELECT * FROM Promotion
SELECT * FROM Sales_Data_Ecommerce

EXEC sp_help Promotion
EXEC sp_help Sales_Data_Ecommerce;

--Check Missing Values
SELECT
	COUNT(*) AS total_rows,
	COUNT(event_date) AS event_date,
	COUNT(Day_of_Week) AS Day_of_Week,
	COUNT(Channel) AS Channel,
	COUNT(event_time) AS event_time,
	COUNT(event_hour) AS event_hour,
	COUNT(event_timezone) AS event_timezone,
	COUNT(event_type) AS event_type,
	COUNT(product_id) AS product_id,
	COUNT(category_id) AS category_id,
	COUNT(category) AS category,
	COUNT(sub_category1) AS sub_category1,
	COUNT(sub_category2) AS sub_category2,
	COUNT(brand) AS brand,
	COUNT(price) AS price,
	COUNT(user_session) AS user_session,
	COUNT(State) AS State,
	COUNT(User_Score) AS User_Score
FROM Sales_Data_Ecommerce;

SELECT
	COUNT(*) AS total_rows,
	COUNT(Promotion_Id) AS Promotion_Id,
	COUNT(Date) AS Date,
	COUNT(Discount) AS Discount,
	COUNT(ProductId) AS ProductId
FROM Promotion;

SELECT * FROM Promotion
WHERE Promotion_Id IS NULL
	OR Date IS NULL
	OR Discount IS NULL
	OR ProductId IS NULL;

DELETE FROM Promotion
WHERE Promotion_Id IS NULL
	AND Date IS NULL
	AND Discount IS NULL
	AND ProductId IS NULL;

--------Understanding the Data------------

SELECT DISTINCT event_type
FROM Sales_Data_Ecommerce;

SELECT DISTINCT Channel
FROM Sales_Data_Ecommerce;

SELECT DISTINCT User_Score
FROM Sales_Data_Ecommerce;

SELECT DISTINCT category
FROM Sales_Data_Ecommerce;

SELECT DISTINCT brand
FROM Sales_Data_Ecommerce;

SELECT DISTINCT State
FROM Sales_Data_Ecommerce;

SELECT COUNT(DISTINCT brand)
FROM Sales_Data_Ecommerce;

SELECT COUNT(DISTINCT State)
FROM Sales_Data_Ecommerce;

SELECT MIN(event_date), MAX(event_date)
FROM Sales_Data_Ecommerce

---------------------Executive KPIs-----------------------------

SELECT COUNT(user_id)AS total_cust, COUNT(DISTINCT user_id) AS unique_cust
FROM Sales_Data_Ecommerce;

SELECT COUNT(DISTINCT product_id)
FROM Sales_Data_Ecommerce;

SELECT COUNT(DISTINCT category)
FROM Sales_Data_Ecommerce;

SELECT COUNT(DISTINCT brand)
FROM Sales_Data_Ecommerce;

SELECT SUM(price) AS revenue
FROM Sales_Data_Ecommerce
WHERE event_type='Purchase';

SELECT COUNT(*) FROM Sales_Data_Ecommerce
WHERE event_type='Purchase';

SELECT AVG(price) FROM Sales_Data_Ecommerce
WHERE event_type='Purchase';

-------------------------Sales Analysis---------------
---revenue by brand
SELECT brand, SUM(price) AS revenue
FROM Sales_Data_Ecommerce
WHERE event_type='Purchase'
GROUP BY brand
ORDER BY revenue DESC;

---revenue by category
SELECT category, SUM(price) AS revenue
FROM Sales_Data_Ecommerce
WHERE event_type='Purchase'
GROUP BY category
ORDER BY revenue DESC;

---revenue by State
SELECT State, SUM(price) AS revenue
FROM Sales_Data_Ecommerce
WHERE event_type='Purchase'
GROUP BY State
ORDER BY revenue DESC;

---revenue by Channel
SELECT Channel, SUM(price) AS revenue
FROM Sales_Data_Ecommerce
WHERE event_type='Purchase'
GROUP BY Channel
ORDER BY revenue DESC;

---daily revenue
SELECT event_date, SUM(price) AS revenue
FROM Sales_Data_Ecommerce
WHERE event_type='Purchase'
GROUP BY event_date
ORDER BY revenue DESC;

---revenue by Day
SELECT Day_of_Week, SUM(price) AS revenue
FROM Sales_Data_Ecommerce
WHERE event_type='Purchase'
GROUP BY Day_of_Week
ORDER BY revenue DESC;

---revenue by hour
SELECT event_hour, SUM(price) AS revenue
FROM Sales_Data_Ecommerce
WHERE event_type='Purchase'
GROUP BY event_hour
ORDER BY revenue DESC;

-----------------------Customer Behaviour-----------------------

---customer funnel
SELECT event_type, COUNT(*) total_event
FROM Sales_Data_Ecommerce
GROUP BY event_type
ORDER BY total_event DESC;

---customer Activity by Channel
SELECT event_type, Channel, COUNT(*) Activity
FROM Sales_Data_Ecommerce
GROUP BY event_type, Channel;

---user Score Distribution
SELECT User_Score, COUNT(*) customers
FROM Sales_Data_Ecommerce
GROUP BY User_Score
ORDER BY customers DESC;

-----------------------Product Analysis---------------------------------

-- Most Viewed Products
SELECT TOP 10 product_id, COUNT(*) views
FROM Sales_Data_Ecommerce
WHERE event_type='View'
GROUP BY product_id
ORDER BY views DESC;

-- Most Purchased Products
SELECT TOP 10 product_id, COUNT(*) purchases
FROM Sales_Data_Ecommerce
WHERE event_type='Purchase'
GROUP BY product_id
ORDER BY purchases DESC;

-- Top Brands by Purchases
SELECT TOP 10 brand, COUNT(*) purchases
FROM Sales_Data_Ecommerce
WHERE event_type='Purchase'
GROUP BY brand
ORDER BY purchases DESC;

-- Top Categories
SELECT TOP 10 category, COUNT(*) purchases
FROM Sales_Data_Ecommerce
WHERE event_type='Purchase'
GROUP BY category
ORDER BY purchases DESC;

--------------------------Promotion Analysis-------------------
SELECT P.Promotion_Id,P.Discount, COUNT(P.ProductId) purchases,
SUM(s.price) revenue
FROM Promotion P
LEFT JOIN Sales_Data_Ecommerce s
ON P.ProductId=s.product_id
AND P.Date=s.event_date
AND event_type='Purchase'
GROUP BY P.Promotion_Id,P.Discount
ORDER BY revenue DESC;

--------------------------Pricing Analysis-------------------
-- Average Price by Brand
SELECT brand, AVG(price) avg_price
FROM Sales_Data_Ecommerce
GROUP BY brand
ORDER BY avg_price DESC;

-- Average Price by category
SELECT category, AVG(price) avg_price
FROM Sales_Data_Ecommerce
GROUP BY category
ORDER BY avg_price DESC;

----------------------------Top 10 Customers by Spending---------------

SELECT TOP 10 user_id,SUM(price) spending
FROM Sales_Data_Ecommerce
WHERE event_type='Purchase'
GROUP BY user_id
ORDER BY spending;

----------------------------Create Views------------------------------------

CREATE VIEW vw_ExecutiveKPIs AS
SELECT
    COUNT(DISTINCT user_id) AS Total_Customers,
    COUNT(DISTINCT product_id) AS Total_Products,
    COUNT(DISTINCT category) AS Total_Categories,
    COUNT(DISTINCT brand) AS Total_Brands,
    COUNT(CASE WHEN event_type='Purchase' THEN 1 END) AS Total_Orders,
    SUM(CASE WHEN event_type='Purchase' THEN price ELSE 0 END) AS Revenue,
    AVG(CASE WHEN event_type='Purchase' THEN price END) AS Avg_Order_Value
FROM Sales_Data_Ecommerce;

CREATE VIEW vw_RevenueByBrand AS
SELECT
    brand,
    SUM(price) Revenue
FROM Sales_Data_Ecommerce
WHERE event_type='Purchase'
GROUP BY brand;

CREATE VIEW vw_RevenueByCategory AS
SELECT
    category,
    SUM(price) Revenue
FROM Sales_Data_Ecommerce
WHERE event_type='Purchase'
GROUP BY category;

CREATE VIEW vw_RevenueByState AS
SELECT
    State,
    SUM(price) Revenue
FROM Sales_Data_Ecommerce
WHERE event_type='Purchase'
GROUP BY State;

CREATE VIEW vw_CustomerFunnel AS
SELECT
    event_type,
    COUNT(*) Total_Events
FROM Sales_Data_Ecommerce
GROUP BY event_type;

CREATE VIEW vw_PromotionPerformance AS
SELECT
    p.Promotion_Id,
    p.Discount,
    COUNT(s.product_id) Purchases,
    SUM(s.price) Revenue
FROM Promotion p
LEFT JOIN Sales_Data_Ecommerce s
ON p.ProductId=s.product_id
AND p.Date=s.event_date
AND s.event_type='Purchase'
GROUP BY
p.Promotion_Id,
p.Discount;

---------------------------------------------------------