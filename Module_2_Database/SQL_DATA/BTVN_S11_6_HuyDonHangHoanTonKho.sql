-- =============================================================================
-- BTVN Session 11 - Bài 6: Hủy Đơn Hàng & Hoàn Tồn Kho (Order Cancellation Transaction)
-- Mục tiêu: Quản lý quy trình đảo ngược giao dịch (Reverse Transaction) hoàn lại tồn kho
-- =============================================================================

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    stock INT NOT NULL CHECK (stock >= 0),
    price DECIMAL(12,2) NOT NULL
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    total_amount DECIMAL(12,2) NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'Completed',
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Khởi tạo sản phẩm: Laptop Dell tồn kho 8 chiếc
INSERT INTO products (product_name, stock, price) VALUES ('Laptop Dell Inspiron', 8, 15000000.00);

-- Tạo một đơn hàng mẫu mua 2 chiếc Laptop Dell (kho còn 6)
INSERT INTO orders (product_id, quantity, total_amount, status) VALUES (1, 2, 30000000.00, 'Completed');
UPDATE products SET stock = stock - 2 WHERE product_id = 1;

-- Tạo Stored Procedure cancel_order
DROP PROCEDURE IF EXISTS cancel_order;
DELIMITER //
CREATE PROCEDURE cancel_order(
    IN p_order_id INT
)
BEGIN
    DECLARE v_prod_id INT;
    DECLARE v_qty INT;
    DECLARE v_current_status VARCHAR(50);
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Lỗi trong quá trình hủy đơn hàng! Đã hủy bỏ thao tác.' AS error_msg;
    END;

    START TRANSACTION;
    
    -- Kiểm tra thông tin đơn hàng
    SELECT product_id, quantity, status 
    INTO v_prod_id, v_qty, v_current_status
    FROM orders 
    WHERE order_id = p_order_id;
    
    IF v_prod_id IS NULL THEN
        ROLLBACK;
        SELECT 'Đơn hàng không tồn tại!' AS message;
    ELSEIF v_current_status = 'Cancelled' THEN
        ROLLBACK;
        SELECT 'Đơn hàng này đã được hủy trước đó rồi!' AS message;
    ELSE
        -- 1. Cập nhật trạng thái đơn hàng thành Cancelled
        UPDATE orders 
        SET status = 'Cancelled' 
        WHERE order_id = p_order_id;
        
        -- 2. Hoàn lại số lượng sản phẩm vào kho
        UPDATE products 
        SET stock = stock + v_qty 
        WHERE product_id = v_prod_id;
        
        COMMIT;
        SELECT 'Hủy đơn hàng thành công và đã hoàn lại số lượng tồn kho!' AS message;
    END IF;
END //
DELIMITER ;

-- Kiểm tra trước khi hủy đơn (Kho = 6)
SELECT * FROM products WHERE product_id = 1;
SELECT * FROM orders WHERE order_id = 1;

-- Thực thi hủy đơn hàng số 1
CALL cancel_order(1);

-- Kiểm tra sau khi hủy đơn (Kho tăng lại thành 8, đơn chuyển sang 'Cancelled')
SELECT * FROM products WHERE product_id = 1;
SELECT * FROM orders WHERE order_id = 1;
