-- =============================================================================
-- BTVN Session 09 - Bài 4: Thủ tục thêm mới khách hàng (Stored Procedure)
-- Mục tiêu: Tạo sp insert_customer nhận thông tin khách hàng và thông báo thành công
-- =============================================================================

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL,
    address VARCHAR(255) NOT NULL
);

-- Tạo Stored Procedure thêm mới khách hàng
DROP PROCEDURE IF EXISTS insert_customer;
DELIMITER //
CREATE PROCEDURE insert_customer(
    IN in_customer_name VARCHAR(50),
    IN in_email VARCHAR(100),
    IN in_phone VARCHAR(15),
    IN in_address VARCHAR(255)
)
BEGIN
    INSERT INTO customers (customer_name, email, phone, address)
    VALUES (in_customer_name, in_email, in_phone, in_address);
    
    SELECT 'Thêm mới khách hàng thành công' AS message;
END //
DELIMITER ;

-- Gọi thực thi Stored Procedure thêm khách hàng
CALL insert_customer('Doan Minh Quan', 'quan.doan@example.com', '0912345678', 'So 9 Kim Ma, Ba Dinh, Hanoi');
CALL insert_customer('Vu Hoang Linh', 'linh.vu@example.com', '0988776655', 'So 12 Pasteur, Quan 1, TP HCM');

-- Kiểm tra dữ liệu đã thêm trong bảng
SELECT * FROM customers;
