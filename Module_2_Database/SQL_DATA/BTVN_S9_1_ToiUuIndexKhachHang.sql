-- =============================================================================
-- BTVN Session 09 - Bài 1: Tối ưu hóa tốc độ tìm kiếm khách hàng (Index)
-- Mục tiêu: Tạo Unique Index cho email và Non-Unique Index cho phone trong customers
-- =============================================================================

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    address VARCHAR(255) NOT NULL
);

INSERT INTO customers (customer_name, email, phone, address) VALUES
('Nguyen Van A', 'vana@example.com', '0901234567', '123 Le Loi, Hanoi'),
('Tran Thi B', 'thib@example.com', '0912345678', '456 Tran Phu, Danang'),
('Le Van C', 'vanc@example.com', '0987654321', '789 Nguyen Hue, Saigon'),
('Pham Thi D', 'thid@example.com', '0933445566', '101 Hung Vuong, Hue');

-- Tạo Unique Index cho email (đảm bảo không trùng và tìm kiếm tức thì)
CREATE UNIQUE INDEX idx_customers_email ON customers(email);

-- Tạo Index thông thường cho phone (tăng tốc độ tìm kiếm theo số điện thoại)
CREATE INDEX idx_customers_phone ON customers(phone);

-- Kiểm tra danh sách Index của bảng customers
SHOW INDEX FROM customers;

-- Kiểm tra kế hoạch thực thi để xác nhận Index được sử dụng
EXPLAIN SELECT * FROM customers WHERE email = 'vana@example.com';
EXPLAIN SELECT * FROM customers WHERE phone = '0901234567';
