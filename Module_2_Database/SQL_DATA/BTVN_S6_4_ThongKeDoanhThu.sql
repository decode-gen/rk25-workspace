-- =============================================================================
-- BTVN Session 06 - Bài 4: Thống kê Doanh thu
-- Mục tiêu: SUM, AVG, GROUP BY, ORDER BY, LIMIT, Subquery doanh thu
-- =============================================================================

CREATE TABLE orders (
    order_id VARCHAR(10) PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_name VARCHAR(100) NOT NULL
);

CREATE TABLE order_details (
    detail_id INT PRIMARY KEY,
    order_id VARCHAR(10),
    product_name VARCHAR(150) NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO orders VALUES 
('DH01', '2026-09-01', 'Nguyen Van A'),
('DH02', '2026-09-05', 'Tran Thi B'),
('DH03', '2026-09-12', 'Le Van C');

INSERT INTO order_details VALUES 
(1, 'DH01', 'iPhone 15 Pro Max', 1, 31000000.00),
(2, 'DH01', 'Op lung MagSafe', 2, 450000.00),
(3, 'DH02', 'Samsung Galaxy S24 Ultra', 1, 28000000.00),
(4, 'DH03', 'iPad Air M2', 2, 16500000.00),
(5, 'DH03', 'Apple Pencil Pro', 2, 3200000.00);

-- 1. Thêm một đơn hàng mới vào bảng orders và chi tiết của đơn hàng đó vào order_details
INSERT INTO orders (order_id, order_date, customer_name) VALUES ('DH04', '2026-09-25', 'Pham Minh D');
INSERT INTO order_details (detail_id, order_id, product_name, quantity, unit_price) VALUES 
(6, 'DH04', 'Macbook Pro 14 M3', 1, 45000000.00),
(7, 'DH04', 'Chuot Apple Magic Mouse', 1, 1900000.00);

-- 2. Tính tổng doanh thu của toàn bộ cửa hàng
SELECT SUM(quantity * unit_price) AS total_store_revenue FROM order_details;

-- 3. Tính doanh thu trung bình của mỗi đơn hàng
SELECT AVG(order_total) AS avg_order_revenue
FROM (
    SELECT order_id, SUM(quantity * unit_price) AS order_total
    FROM order_details
    GROUP BY order_id
) AS t;

-- 4. Tìm và hiển thị thông tin của đơn hàng có doanh thu cao nhất
SELECT o.order_id, o.order_date, o.customer_name, SUM(od.quantity * od.unit_price) AS total_revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.order_id, o.order_date, o.customer_name
ORDER BY total_revenue DESC
LIMIT 1;

-- 5. Tìm và hiển thị danh sách 3 sản phẩm bán chạy nhất dựa trên tổng số lượng đã bán
SELECT product_name, SUM(quantity) AS total_sold_quantity
FROM order_details
GROUP BY product_name
ORDER BY total_sold_quantity DESC
LIMIT 3;
