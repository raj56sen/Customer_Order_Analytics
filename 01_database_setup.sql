CUSTOMER ORDER ANALYTICS PROJECT
DATABASE SETUP AND SAMPLE DATA 

CREATING DATABASE
CREATE DATABASE customer_analytics;
USE customer_analytics;

FIRST TABLE (CUSTOMERS)
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15),
    city VARCHAR(50),
    country VARCHAR(50),
    registration_date DATE NOT NULL,
    customer_segment VARCHAR(20)
);

SECOND TABLE (PRODUCTS)
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT
);

THIRD TABLE (ORDER_ITEMS)
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    item_total DECIMAL(12, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERTING SAMPLE DATA IN THE TABLE
INSERT CUSTOMERS 
INSERT INTO customers (customer_name, email, phone, city, country, registration_date) VALUES
('Rajesh Kumar', 'rajesh.k@email.com', '9876543210', 'Mumbai', 'India', '2023-01-15'),
('Priya Sharma', 'priya.s@email.com', '9876543211', 'Delhi', 'India', '2023-02-20'),
('Amit Patel', 'amit.p@email.com', '9876543212', 'Bangalore', 'India', '2023-03-10'),
('Sneha Gupta', 'sneha.g@email.com', '9876543213', 'Pune', 'India', '2023-01-05'),
('Vikram Singh', 'vikram.s@email.com', '9876543214', 'Hyderabad', 'India', '2023-04-12'),
('Ananya Desai', 'ananya.d@email.com', '9876543215', 'Chennai', 'India', '2023-02-28'),
('Rohan Verma', 'rohan.v@email.com', '9876543216', 'Kolkata', 'India', '2023-05-01'),
('Divya Nair', 'divya.n@email.com', '9876543217', 'Kochi', 'India', '2023-03-15'),
('Kunal Mishra', 'kunal.m@email.com', '9876543218', 'Lucknow', 'India', '2023-01-20'),
('Pooja Singh', 'pooja.s@email.com', '9876543219', 'Jaipur', 'India', '2023-06-10'),
('Arjun Kumar', 'arjun.k@email.com', '9876543220', 'Indore', 'India', '2023-02-14'),
('Neha Kapoor', 'neha.k@email.com', '9876543221', 'Ahmedabad', 'India', '2023-04-22'),
('Sameer Khan', 'sameer.k@email.com', '9876543222', 'Nagpur', 'India', '2023-03-08'),
('Ritika Chopra', 'ritika.c@email.com', '9876543223', 'Surat', 'India', '2023-05-30'),
('Harsh Pandey', 'harsh.p@email.com', '9876543224', 'Vadodara', 'India', '2023-01-25'),
('Kavya Rao', 'kavya.r@email.com', '9876543225', 'Visakhapatnam', 'India', '2023-06-05'),
('Nitin Joshi', 'nitin.j@email.com', '9876543226', 'Bhopal', 'India', '2023-02-11'),
('Shreya Saxena', 'shreya.s@email.com', '9876543227', 'Chandigarh', 'India', '2023-04-18'),
('Manish Reddy', 'manish.r@email.com', '9876543228', 'Gurgaon', 'India', '2023-03-22'),
('Anjali Verma', 'anjali.v@email.com', '9876543229', 'Noida', 'India', '2023-05-12');

INSERT PRODUCTS
INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Laptop Pro', 'Electronics', 85000.00, 25),
('Wireless Mouse', 'Electronics', 1500.00, 100),
('USB-C Cable', 'Electronics', 500.00, 200),
('Phone Stand', 'Accessories', 800.00, 150),
('Desk Lamp', 'Furniture', 2500.00, 60),
('Office Chair', 'Furniture', 12000.00, 30),
('Mechanical Keyboard', 'Electronics', 5500.00, 80),
('Monitor 24"', 'Electronics', 15000.00, 40),
('Webcam 1080p', 'Electronics', 3500.00, 70),
('Backpack', 'Accessories', 2000.00, 120),
('Notebook Set', 'Stationery', 300.00, 500),
('Pen Set', 'Stationery', 250.00, 400),
('Screen Protector', 'Accessories', 400.00, 300),
('Power Bank', 'Electronics', 1800.00, 180),
('HDMI Cable', 'Electronics', 600.00, 250);

INSERT ORDERS
INSERT INTO orders (customer_id, order_date, order_status, total_amount) VALUES
(1, '2024-01-10', 'Completed', 87000),
(2, '2024-01-15', 'Completed', 3500),
(3, '2024-01-20', 'Completed', 18500),
(4, '2024-02-01', 'Completed', 2300),
(1, '2024-02-05', 'Completed', 5500),
(5, '2024-02-10', 'Completed', 85500),
(6, '2024-02-15', 'Completed', 1500),
(7, '2024-02-20', 'Completed', 15800),
(8, '2024-03-01', 'Completed', 12800),
(2, '2024-03-05', 'Completed', 5000),
(9, '2024-03-10', 'Completed', 3000),
(10, '2024-03-15', 'Completed', 18000),
(3, '2024-03-20', 'Completed', 2500),
(11, '2024-04-01', 'Completed', 87500),
(12, '2024-04-05', 'Completed', 4000),
(1, '2024-04-10', 'Completed', 1800),
(4, '2024-04-15', 'Completed', 85000),
(5, '2024-04-20', 'Completed', 3500),
(13, '2024-05-01', 'Completed', 12500),
(14, '2024-05-05', 'Completed', 2300),
(6, '2024-05-10', 'Completed', 5500),
(15, '2024-05-15', 'Completed', 1500),
(7, '2024-05-20', 'Completed', 18500),
(2, '2024-06-01', 'Completed', 4500),
(8, '2024-06-05', 'Completed', 85000),
(9, '2024-06-10', 'Completed', 3000),
(10, '2024-06-15', 'Completed', 2500),
(16, '2024-06-20', 'Completed', 87500),
(17, '2024-07-01', 'Completed', 1800),
(18, '2024-07-05', 'Completed', 5500);

INSERT ORDER ITEMS
INSERT INTO order_items (order_id, product_id, quantity, unit_price, item_total) VALUES
(1, 1, 1, 85000, 85000),
(1, 2, 1, 1500, 1500),
(2, 9, 1, 3500, 3500),
(3, 8, 1, 15000, 15000),
(3, 2, 1, 1500, 1500),
(3, 10, 1, 2000, 2000),
(4, 4, 1, 800, 800),
(4, 11, 5, 300, 1500),
(5, 7, 1, 5500, 5500),
(6, 1, 1, 85000, 85000),
(6, 12, 5, 250, 1250),
(6, 3, 1, 500, 500),
(7, 2, 1, 1500, 1500),
(8, 8, 1, 15000, 15000),
(8, 13, 2, 400, 800),
(9, 6, 1, 12000, 12000),
(9, 11, 2, 300, 600),
(9, 14, 1, 1800, 1800),
(10, 7, 1, 5000, 5000),
(11, 9, 1, 3000, 3000),
(12, 8, 1, 15000, 15000),
(12, 4, 1, 800, 800),
(12, 3, 1, 600, 600),
(12, 10, 1, 1800, 1800),
(13, 5, 1, 2500, 2500),
(14, 1, 1, 85000, 85000),
(14, 6, 1, 500, 500),
(15, 14, 1, 1800, 1800),
(16, 1, 1, 85000, 85000),
(17, 9, 1, 3500, 3500),
(18, 6, 1, 12000, 12000),
(18, 11, 2, 300, 600),
(19, 5, 1, 2500, 2500),
(20, 4, 1, 800, 800),
(20, 11, 4, 300, 1200),
(20, 12, 2, 250, 500),
(21, 7, 1, 5500, 5500),
(22, 2, 1, 1500, 1500),
(23, 8, 1, 15000, 15000),
(23, 10, 1, 2000, 2000),
(23, 3, 1, 500, 500),
(24, 5, 1, 4500, 4500),
(25, 1, 1, 85000, 85000),
(26, 9, 1, 3000, 3000),
(27, 4, 1, 800, 800),
(27, 11, 2, 300, 600),
(27, 14, 1, 1200, 1200),
(28, 1, 1, 87500, 87500),
(29, 14, 1, 1800, 1800),
(30, 7, 1, 5500, 5500);

CREATING INDEXES
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_date ON orders(order_date);
CREATE INDEX idx_order_items_order ON order_items(order_id);
CREATE INDEX idx_order_items_product ON order_items(product_id);
CREATE INDEX idx_products_category ON products(category);

VERIFYING THE DATA 
SELECT 'Customers Created' AS Status, COUNT(*) AS Count FROM customers
UNION ALL
SELECT 'Products Created' AS Status, COUNT(*) AS Count FROM products
UNION ALL
SELECT 'Orders Created' AS Status, COUNT(*) AS Count FROM orders
UNION ALL
SELECT 'Order Items Created' AS Status, COUNT(*) AS Count FROM order_items;
