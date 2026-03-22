-- Inserting Data


INSERT INTO Customers(customer_id, name, email, city)
VALUES 
	(1,'Sumit', 'Sumit22@gmail.com', 'Pune'),
	(2,'Rohan', 'Rohanss@gmail.com', 'Jaipur'),
	(3,'Amit', 'AAmit@gmail.com', 'Mumbai'),
	(4,'Krishna', 'KrishnaS@gmail.com', 'Mumbai'),
	(5,'Prerena', 'PrerenaW@gmail.com', 'Surat'),
	(6,'Joe', 'Joe45@gmail.com', 'Delhi'),
	(7,'Suraj', 'Suraj2@gmail.com', 'Pune'),
	(8,'Bhavna', 'Bhav@gmail.com', 'Jaipur')


INSERT INTO Products(product_id, product_name, category, price)
VALUES
(1, 'Laptop', 'Electronics', 60000),
(2, 'Mobile', 'Electronics', 20000),
(3, 'Headphones', 'Electronics', 3000),
(4, 'T-Shirt', 'Clothing', 800),
(5, 'Jeans', 'Clothing', 1500),
(6, 'Shoes', 'Clothing', 2500),
(7, 'Book - SQL', 'Books', 500),
(8, 'Book - Java', 'Books', 700),
(9, 'Watch', 'Accessories', 2000),
(10, 'Backpack', 'Accessories', 1200);


INSERT INTO Orders(order_id, customer_id, order_date)
VALUES
(101, 1, '2024-01-10'),
(102, 2, '2024-01-12'),
(103, 3, '2024-01-15'),
(104, 1, '2024-01-18'),
(105, 4, '2024-01-20'),
(106, 5, '2024-01-22'),
(107, 6, '2024-01-25'),
(108, 2, '2024-01-28');


INSERT INTO Order_items(order_item_id, order_id, product_id, quantity)
VALUES
(1, 101, 1, 1),
(2, 101, 3, 2),
(3, 102, 2, 1),
(4, 102, 4, 3),
(5, 103, 5, 1),
(6, 104, 1, 1),
(7, 104, 7, 2),
(8, 105, 6, 1),
(9, 106, 8, 1),
(10, 106, 9, 2),
(11, 107, 10, 1),
(12, 108, 2, 2),
(13, 108, 3, 1);




-- CHECKING ALL TABLES --

SELECT * FROM Customers
SELECT * FROM Products
SELECT * FROM Orders
SELECT * FROM Order_items





-- Select Queries -- 

-- Select All customers
SELECT * FROM Customers


-- Select Customers from Mumbai
SELECT * FROM Customers
WHERE city = 'Mumbai'


-- Select Products above ₹2000
SELECT * FROM Products
WHERE price > 2000


-- Orders sorted by date
SELECT * FROM Orders
WHERE order_date > '2024-01-15' 





-- Sorting orders By starting date using ORDER BY
SELECT * FROM Orders
ORDER BY order_date ASC






-- JOINS --


-- Joining 2 tables using INNER JOIN, SHOW - Customer name, order id, order date

SELECT name, order_id , order_date
FROM Customers AS C
INNER JOIN  Orders as O
	ON C.customer_id = O.customer_id 


-- Joining 3 Tables. Customers, orders and order_items.
-- where we show Name from customers table, order id from orders table and product_it and quantity from Order_items table.

SELECT
	C.name, O.order_id , OI.product_id, OI.quantity
FROM Customers AS C
INNER JOIN  Orders as O
	ON C.customer_id = O.customer_id 
INNER JOIN  Order_items as OI
	ON  OI.order_id = O.order_id



-- Joining all 4 tables Full join, showing - Customer name , product name, quantity

SELECT C.name, P.product_name, OI.quantity
FROM Customers AS C
INNER JOIN Orders AS O
	ON C.customer_id = O.customer_id
INNER JOIN  Order_items as OI
	ON  OI.order_id = O.order_id
INNER JOIN Products AS P
	ON OI.product_id = P.product_id 







-- GROUP BY CLAUSE --


-- 1) Find total orders per customers

SELECT C.name , COUNT (O.order_id) AS total_orders
FROM Customers AS C
INNER JOIN Orders AS O
	ON C.customer_id = O.customer_id
GROUP BY C.name


-- 2) Total quantity sold per product

SELECT P.product_name, SUM(OI.quantity) AS total_quantity
FROM Products AS P
JOIN Order_items AS OI
ON P.product_id = OI.product_id
GROUP BY P.product_name


-- 3) Total orders per customer

Select C.name, SUM(OI.quantity) AS total_items
FROM Customers as C
JOIN Orders AS O
	ON C.customer_id = O.customer_id
JOIN  Order_items as OI
	ON  OI.order_id = O.order_id
GROUP BY C.name








-- SUBQUERIES --


-- 1) Find customers who placed more than one order

SELECT name 
FROM Customers
WHERE customer_id IN (
	SELECT customer_id
	FROM Orders
	GROUP BY customer_id
	HAVING COUNT(order_id) > 0
);



-- 2) Find products with price above average

SELECT product_name 
FROM Products
WHERE price > (
	SELECT AVG(price) FROM Products
)










-- CASE -- 


-- Categorize products: Expensive (> 20000) , Medium (5000–20000), Cheap (< 5000)

SELECT product_name,
CASE
	WHEN price > 20000 THEN 'EXPENSIVE'
	WHEN price BETWEEN 5000 AND 20000 THEN 'MEDIUM'
	ELSE 'CHEAP'
END AS category_type
FROM Products