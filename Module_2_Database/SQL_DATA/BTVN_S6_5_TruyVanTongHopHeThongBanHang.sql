-- =============================================================================
-- BTVN Session 06 - Bài 5: Truy vấn tổng hợp cho hệ thống bán hàng
-- Mục tiêu: JOIN, GROUP BY, ALIAS, ORDER BY, LIMIT, Subquery trên 5 bảng
-- =============================================================================

CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    price DECIMAL(12,2) NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL
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
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Khởi tạo dữ liệu
INSERT INTO categories VALUES (1, 'Dien thoai'), (2, 'Phu kien'), (3, 'Do gia dung');
INSERT INTO products VALUES 
(1, 'iPhone 15 Pro', 28000000.00, 1),
(2, 'Samsung S24', 22000000.00, 1),
(3, 'Cap sac nhanh C to C', 250000.00, 2),
(4, 'Tai nghe Airpods 3', 3900000.00, 2),
(5, 'May loc khong khi Xiaomi', 3500000.00, 3),
(6, 'Robot hut bui Deebot', 8500000.00, 3),
(7, 'May say toc ion am (Chua ban)', 650000.00, 3);

INSERT INTO customers VALUES 
('C01', 'Tran Van Hung'),
('C02', 'Nguyen Mai Lan'),
('C03', 'Hoang Quoc Viet'),
('C04', 'Vu Thu Trang');

INSERT INTO orders VALUES 
('O101', '2026-09-01', 'C01'),
('O102', '2026-09-03', 'C02'),
('O103', '2026-09-05', 'C01'),
('O104', '2026-09-10', 'C03');

INSERT INTO order_details VALUES 
(1, 'O101', 1, 1, 28000000.00),
(2, 'O101', 3, 2, 250000.00),
(3, 'O102', 2, 1, 22000000.00),
(4, 'O103', 4, 1, 3900000.00),
(5, 'O104', 5, 1, 3500000.00);

-- 1. Liệt kê sản phẩm cùng với tên danh mục tương ứng
SELECT p.product_id, p.product_name, p.price, c.category_name
FROM products p
JOIN categories c ON p.category_id = c.category_id
ORDER BY c.category_name, p.price DESC;

-- 2. Đếm số đơn hàng của từng khách hàng
SELECT c.customer_id, c.customer_name, COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 3. Xác định 5 khách hàng có tổng doanh thu chi tiêu cao nhất
SELECT c.customer_id, c.customer_name, COALESCE(SUM(od.quantity * od.price), 0) AS total_spending
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spending DESC
LIMIT 5;

-- 4. Tìm các sản phẩm chưa từng xuất hiện trong bất kỳ đơn hàng nào
SELECT p.product_id, p.product_name, p.price
FROM products p
LEFT JOIN order_details od ON p.product_id = od.product_id
WHERE od.product_id IS NULL;

-- 5. Tìm những khách hàng đã mua sản phẩm thuộc danh mục có số lượng sản phẩm lớn nhất
SELECT DISTINCT c.customer_id, c.customer_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE p.category_id = (
    SELECT category_id
    FROM products
    GROUP BY category_id
    ORDER BY COUNT(product_id) DESC
    LIMIT 1
);
