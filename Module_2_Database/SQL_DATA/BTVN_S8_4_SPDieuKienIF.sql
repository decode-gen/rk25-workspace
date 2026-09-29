-- =============================================================================
-- BTVN Session 08 - Bài 4: Stored Procedure có câu lệnh điều kiện IF
-- Mục tiêu: Tạo sp_check_order_value phân loại đơn hàng (>= 5tr: giá trị cao)
-- =============================================================================

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    total_amount DECIMAL(10,2) NOT NULL
);

INSERT INTO orders (total_amount) VALUES
(2500000.00),
(6800000.00),
(5000000.00),
(1200000.00);

-- Tạo Stored Procedure kiểm tra giá trị đơn hàng bằng IF-ELSE
DROP PROCEDURE IF EXISTS sp_check_order_value;
DELIMITER //
CREATE PROCEDURE sp_check_order_value(IN p_total DECIMAL(10,2))
BEGIN
    IF p_total >= 5000000.00 THEN
        SELECT p_total AS order_total, 'Đơn hàng giá trị cao' AS message;
    ELSE
        SELECT p_total AS order_total, 'Đơn hàng bình thường' AS message;
    END IF;
END //
DELIMITER ;

-- Kiểm thử với các trường hợp:
CALL sp_check_order_value(7500000.00);
CALL sp_check_order_value(3200000.00);
CALL sp_check_order_value(5000000.00);
