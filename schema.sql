
 USE EcommerceDB

CREATE TABLE Customers(
	customer_id INT PRIMARY KEY,
	name VARCHAR(50),
	email VARCHAR(50),
	city VARCHAR(20)
)


CREATE TABLE Products(
	product_id INT PRIMARY KEY,
	product_name VARCHAR(100),
	category VARCHAR(50),
	price DECIMAL(10,2)
)


CREATE TABLE Orders(
	order_id INT PRIMARY KEY,
	customer_id INT,
	order_date DATE
	FOREIGN KEY (customer_id) REFERENCES Customers (customer_id)
)


CREATE TABLE Order_items(
	order_item_id INT PRIMARY KEY,
	order_id INT,
	product_id INT,
	quantity INT,
	FOREIGN KEY (ORDER_id) REFERENCES orders (order_id),
	FOREIGN KEY (product_id) REFERENCES Products (product_id)
)