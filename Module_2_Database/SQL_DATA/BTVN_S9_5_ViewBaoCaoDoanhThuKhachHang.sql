-- =============================================================================
-- BTVN Session 09 - Bài 5: Báo cáo doanh thu theo khách hàng (View phức tạp)
-- Mục tiêu: Tạo view_customer_spending thống kê total_orders và total_spent bằng JOIN + GROUP BY
-- =============================================================================

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL,
    address VARCHAR(255) NOT NULL
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    price DECIMAL(12,2) NOT NULL CHECK (price > 0),
    stock INT NOT NULL CHECK (stock >= 0)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    total_amount DECIMAL(12,2) NOT NULL CHECK (total_amount > 0),
    status ENUM('Pending', 'Success', 'Cancel') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Nạp dữ liệu mẫu customers (5 khách hàng)
INSERT INTO customers (customer_name, email, phone, address) VALUES
('Nguyen Van An', 'an@email.com', '0901000001', 'Hanoi'),
('Tran Thi Bich', 'bich@email.com', '0901000002', 'Danang'),
('Le Hoang Nam', 'nam@email.com', '0901000003', 'Saigon'),
('Pham Minh Tuan', 'tuan@email.com', '0901000004', 'Hue'),
('Doan Thu Ha', 'ha@email.com', '0901000005', 'Hai Phong');

-- Nạp dữ liệu mẫu products (5 sản phẩm)
INSERT INTO products (product_name, price, stock) VALUES
('Ban phim co', 1200000.00, 30),
('Chuot gaming', 600000.00, 50),
('Man hinh 27 inch', 4500000.00, 15),
('Tai nghe Bluetooth', 1500000.00, 25),
('Gia treo man hinh', 450000.00, 40);

-- Nạp 20 bản ghi đơn hàng
INSERT INTO orders (customer_id, product_id, quantity, total_amount, status) VALUES
(1, 1, 1, 1200000.00, 'Success'),
(1, 2, 2, 1200000.00, 'Success'),
(1, 3, 1, 4500000.00, 'Success'),
(2, 4, 1, 1500000.00, 'Success'),
(2, 5, 2, 900000.00, 'Success'),
(3, 1, 2, 2400000.00, 'Success'),
(3, 3, 1, 4500000.00, 'Success'),
(3, 4, 1, 1500000.00, 'Success'),
(4, 2, 1, 600000.00, 'Success'),
(4, 5, 1, 450000.00, 'Success'),
(1, 4, 1, 1500000.00, 'Success'),
(2, 1, 1, 1200000.00, 'Pending'),
(3, 2, 3, 1800000.00, 'Success'),
(4, 3, 1, 4500000.00, 'Success'),
(5, 5, 4, 1800000.00, 'Success'),
(5, 1, 1, 1200000.00, 'Success'),
(1, 5, 2, 900000.00, 'Success'),
(2, 2, 1, 600000.00, 'Success'),
(3, 5, 1, 450000.00, 'Success'),
(5, 4, 2, 3000000.00, 'Success');

-- Tạo View báo cáo doanh thu theo khách hàng
DROP VIEW IF EXISTS view_customer_spending;
CREATE VIEW view_customer_spending AS
SELECT 
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- Kiểm tra kết quả báo cáo
SELECT * FROM view_customer_spending ORDER BY total_spent DESC;
