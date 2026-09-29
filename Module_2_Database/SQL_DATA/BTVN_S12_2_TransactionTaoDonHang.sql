-- =============================================================================
-- BTVN Session 12 - Bài 2: Transaction Tạo Đơn Hàng Ecommerce (sp_create_order)
-- Mục tiêu: Quản lý tính toàn vẹn đa bảng khi tạo đơn hàng mới và trừ tồn kho
-- =============================================================================

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (customer_id INT AUTO_INCREMENT PRIMARY KEY, customer_name VARCHAR(100));
CREATE TABLE products (product_id INT AUTO_INCREMENT PRIMARY KEY, product_name VARCHAR(100), price DECIMAL(10,2));
CREATE TABLE inventory (product_id INT PRIMARY KEY, stock INT NOT NULL CHECK (stock >= 0));
CREATE TABLE orders (order_id INT AUTO_INCREMENT PRIMARY KEY, customer_id INT, status VARCHAR(50) DEFAULT 'Pending');
CREATE TABLE order_items (item_id INT AUTO_INCREMENT PRIMARY KEY, order_id INT, product_id INT, quantity INT, price DECIMAL(10,2));

INSERT INTO customers VALUES (1, 'Le Van Cuong');
INSERT INTO products VALUES (1, 'Ban Phim Co', 1500000.00);
INSERT INTO inventory VALUES (1, 15);

-- Tạo Stored Procedure sp_create_order
DROP PROCEDURE IF EXISTS sp_create_order;
DELIMITER //
CREATE PROCEDURE sp_create_order(
    IN p_customer_id INT,
    IN p_product_id INT,
    IN p_quantity INT,
    IN p_price DECIMAL(10,2)
)
BEGIN
    DECLARE v_stock INT DEFAULT 0;
    DECLARE v_new_order_id INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Lỗi phát sinh trong quá trình tạo đơn hàng! Đã ROLLBACK.' AS status;
    END;

    START TRANSACTION;
    
    -- Kiểm tra số lượng tồn kho
    SELECT stock INTO v_stock FROM inventory WHERE product_id = p_product_id;
    
    IF v_stock IS NULL OR v_stock < p_quantity THEN
        ROLLBACK;
        SELECT 'Hàng trong kho không đủ để đáp ứng đơn hàng!' AS message;
    ELSE
        -- 1. Thêm một đơn hàng mới vào bảng orders
        INSERT INTO orders (customer_id, status) VALUES (p_customer_id, 'Pending');
        SET v_new_order_id = LAST_INSERT_ID();
        
        -- 2. Thêm sản phẩm vào bảng order_items
        INSERT INTO order_items (order_id, product_id, quantity, price) 
        VALUES (v_new_order_id, p_product_id, p_quantity, p_price);
        
        -- 3. Cập nhật giảm số lượng trong kho
        UPDATE inventory 
        SET stock = stock - p_quantity 
        WHERE product_id = p_product_id;
        
        COMMIT;
        SELECT 'Tạo đơn hàng thành công!' AS message, v_new_order_id AS order_id;
    END IF;
END //
DELIMITER ;

-- Gọi tạo đơn mua 3 chiếc bàn phím cơ
CALL sp_create_order(1, 1, 3, 1500000.00);

-- Kiểm tra lại orders, order_items và inventory (stock còn 12)
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM inventory;
