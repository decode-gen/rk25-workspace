-- =============================================================================
-- BTVN Session 06 - Bài 2: Quản lý Khách hàng & Đơn hàng
-- Mục tiêu: Quản lý khách hàng, đơn hàng, INNER JOIN, LEFT JOIN, GROUP BY, Subquery
-- =============================================================================

CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100)
);

CREATE TABLE orders (
    order_id VARCHAR(10) PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id VARCHAR(10),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id VARCHAR(10),
    product_name VARCHAR(150) NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Dữ liệu mẫu ban đầu
INSERT INTO customers VALUES 
('KH01', 'Nguyen Van An', 'an.nguyen@gmail.com'),
('KH02', 'Tran Thi Bich', 'bich.tran@gmail.com');

-- 1. Thêm 2 khách hàng mới vào bảng customers
INSERT INTO customers (customer_id, customer_name, email) VALUES 
('KH03', 'Le Hoang Nam', 'nam.le@gmail.com'),
('KH04', 'Pham Thu Ha', 'ha.pham@gmail.com');

INSERT INTO orders VALUES 
('ORD101', '2026-09-10', 'KH01'),
('ORD102', '2026-09-15', 'KH02'),
('ORD103', '2026-09-20', 'KH01');

INSERT INTO order_details VALUES 
(1, 'ORD101', 'Laptop Dell XPS', 1, 32000000.00),
(2, 'ORD101', 'Chuot khong day', 2, 450000.00),
(3, 'ORD102', 'Man hinh LG 27 inch', 1, 6500000.00),
(4, 'ORD103', 'Ban phim co Bluetooth', 1, 1800000.00);

-- 2. Liệt kê những khách hàng đã có ít nhất một đơn hàng (DISTINCT hoặc INNER JOIN)
SELECT DISTINCT c.customer_id, c.customer_name, c.email
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;

-- 3. Tìm những khách hàng chưa từng đặt đơn hàng nào (LEFT JOIN + IS NULL)
SELECT c.customer_id, c.customer_name, c.email
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 4. Tính toán tổng doanh thu mà mỗi khách hàng đã mang lại
SELECT c.customer_id, c.customer_name, COALESCE(SUM(od.quantity * od.price), 0) AS total_revenue
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_details od ON o.order_id = od.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_revenue DESC;

-- 5. Xác định khách hàng đã mua sản phẩm có giá cao nhất
SELECT c.customer_id, c.customer_name, od.product_name, od.price
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
WHERE od.price = (SELECT MAX(price) FROM order_details);
