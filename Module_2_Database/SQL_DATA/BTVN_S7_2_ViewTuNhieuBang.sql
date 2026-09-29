-- =============================================================================
-- BTVN Session 07 - Bài 2: View từ nhiều bảng
-- Mục tiêu: Tạo VIEW v_order_info kết hợp đơn hàng và tên khách hàng
-- =============================================================================

CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL
);

CREATE TABLE orders (
    order_id VARCHAR(20) PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers VALUES 
('KH01', 'Cong ty Sun Asterisk'),
('KH02', 'Tap doan FPT Software');

INSERT INTO orders VALUES 
('ORD_01', '2026-09-01', 'KH01'),
('ORD_02', '2026-09-05', 'KH02'),
('ORD_03', '2026-09-12', 'KH01');

-- Yêu cầu: Tạo VIEW v_order_info kết hợp 2 bảng customers và orders
CREATE VIEW v_order_info AS
SELECT o.order_id, o.order_date, c.customer_name
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

-- Kiểm tra truy vấn từ View
SELECT * FROM v_order_info;
