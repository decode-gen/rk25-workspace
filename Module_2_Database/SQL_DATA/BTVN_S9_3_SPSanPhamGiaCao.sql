-- =============================================================================
-- BTVN Session 09 - Bài 3: Thủ tục lấy về danh sách sản phẩm giá cao
-- Mục tiêu: Tạo bảng products với CHECK constraint và Procedure get_high_value_products()
-- =============================================================================

DROP TABLE IF EXISTS products;
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    price DECIMAL(12,2) NOT NULL CHECK (price > 0),
    stock INT NOT NULL CHECK (stock >= 0)
);

-- Thêm 20 bản ghi mẫu
INSERT INTO products (product_name, price, stock) VALUES
('Chuot Bosston', 120000.00, 50),
('Lot chuot RGB', 150000.00, 100),
('USB Kingston 64GB', 180000.00, 40),
('Tai nghe nhét tai Sony', 450000.00, 30),
('Ban phim van phong Logitech', 320000.00, 60),
('Gia do laptop Nhom', 280000.00, 25),
('Day cap HDMI 2.1', 200000.00, 80),
('Webcam Full HD 1080P', 750000.00, 20),
('Loa vi tinh Bluetooth Microlab', 890000.00, 15),
('Hub Type-C 7 trong 1', 650000.00, 35),
('Ban phim co AKKO 3087', 1250000.00, 18),
('Man hinh Dell 24 inch IPS', 3200000.00, 12),
('Laptop Lenovo ThinkPad T14', 18500000.00, 8),
('Ổ cứng di động SSD 1TB Samsung', 2400000.00, 14),
('Tai nghe Sony WH-1000XM5', 6800000.00, 7),
('Man hinh Gaming LG 27 inch 144Hz', 4500000.00, 10),
('Ghe Cong thai hoc Sihoo', 3800000.00, 6),
('Chuot Apple Magic Mouse', 1900000.00, 16),
('Card do hoa RTX 4060', 8200000.00, 5),
('Micro Rode Wireless GO II', 5200000.00, 9);

-- Tạo Stored Procedure lấy các sản phẩm có giá > 1.000.000 VNĐ
DROP PROCEDURE IF EXISTS get_high_value_products;
DELIMITER //
CREATE PROCEDURE get_high_value_products()
BEGIN
    SELECT product_id, product_name, price, stock
    FROM products
    WHERE price > 1000000.00
    ORDER BY price DESC;
END //
DELIMITER ;

-- Gọi thực thi Stored Procedure
CALL get_high_value_products();
