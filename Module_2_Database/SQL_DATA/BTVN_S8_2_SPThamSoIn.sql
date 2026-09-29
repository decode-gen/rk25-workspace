-- =============================================================================
-- BTVN Session 08 - Bài 2: Stored Procedure có tham số IN
-- Mục tiêu: Tạo thủ tục sp_get_products_by_category lọc sản phẩm theo loại
-- =============================================================================

DROP TABLE IF EXISTS products;
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category VARCHAR(50) NOT NULL
);

INSERT INTO products (product_name, price, category) VALUES
('Laptop Dell Inspiron', 15000000.00, 'Dien tu'),
('Chuot khong day Logitech', 350000.00, 'Phu kien'),
('Ban phim co DareU', 850000.00, 'Phu kien'),
('Dien thoai Samsung Galaxy', 12000000.00, 'Dien tu'),
('Tai nghe Sony WH-1000XM4', 5500000.00, 'Am thanh');

-- Tạo Stored Procedure với 1 tham số IN
DROP PROCEDURE IF EXISTS sp_get_products_by_category;
DELIMITER //
CREATE PROCEDURE sp_get_products_by_category(IN p_category VARCHAR(50))
BEGIN
    SELECT product_id, product_name, price, category 
    FROM products
    WHERE category = p_category;
END //
DELIMITER ;

-- Kiểm thử thực thi Stored Procedure
CALL sp_get_products_by_category('Dien tu');
CALL sp_get_products_by_category('Phu kien');
