-- =============================================================================
-- BTVN Session 12 - Bài 3: Transaction Thanh Toán & Hủy Đơn Hàng Ecommerce
-- Mục tiêu: Viết thủ tục sp_pay_order và sp_cancel_order đảm bảo Atomicity
-- =============================================================================

DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS inventory;

CREATE TABLE inventory (product_id INT PRIMARY KEY, stock INT NOT NULL CHECK (stock >= 0));
CREATE TABLE orders (order_id INT AUTO_INCREMENT PRIMARY KEY, customer_id INT, status VARCHAR(50) DEFAULT 'Pending');
CREATE TABLE order_items (item_id INT AUTO_INCREMENT PRIMARY KEY, order_id INT, product_id INT, quantity INT);
CREATE TABLE payments (payment_id INT AUTO_INCREMENT PRIMARY KEY, order_id INT, payment_method VARCHAR(50), payment_date DATETIME DEFAULT CURRENT_TIMESTAMP);

INSERT INTO inventory VALUES (1, 10);
INSERT INTO orders (customer_id, status) VALUES (1, 'Pending'), (1, 'Pending');
INSERT INTO order_items (order_id, product_id, quantity) VALUES (1, 1, 2), (2, 1, 3);

-- 1. Thủ tục thanh toán đơn hàng: sp_pay_order
DROP PROCEDURE IF EXISTS sp_pay_order;
DELIMITER //
CREATE PROCEDURE sp_pay_order(
    IN p_order_id INT,
    IN p_payment_method VARCHAR(50)
)
BEGIN
    DECLARE v_status VARCHAR(50);
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Lỗi thanh toán! Giao dịch bị hủy.' AS status;
    END;

    START TRANSACTION;
    SELECT status INTO v_status FROM orders WHERE order_id = p_order_id;
    
    IF v_status <> 'Pending' THEN
        ROLLBACK;
        SELECT 'Chỉ đơn hàng ở trạng thái Pending mới được phép thanh toán!' AS message;
    ELSE
        INSERT INTO payments (order_id, payment_method) VALUES (p_order_id, p_payment_method);
        UPDATE orders SET status = 'Completed' WHERE order_id = p_order_id;
        COMMIT;
        SELECT 'Thanh toán đơn hàng thành công!' AS message;
    END IF;
END //

-- 2. Thủ tục hủy đơn hàng và hoàn trả kho: sp_cancel_order
CREATE PROCEDURE sp_cancel_order(IN p_order_id INT)
BEGIN
    DECLARE v_status VARCHAR(50);
    DECLARE v_prod_id INT;
    DECLARE v_qty INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Lỗi hủy đơn hàng! Giao dịch bị hủy.' AS status;
    END;

    START TRANSACTION;
    SELECT status INTO v_status FROM orders WHERE order_id = p_order_id;
    
    IF v_status <> 'Pending' THEN
        ROLLBACK;
        SELECT 'Không thể hủy đơn hàng không ở trạng thái Pending!' AS message;
    ELSE
        SELECT product_id, quantity INTO v_prod_id, v_qty FROM order_items WHERE order_id = p_order_id LIMIT 1;
        UPDATE inventory SET stock = stock + v_qty WHERE product_id = v_prod_id;
        DELETE FROM order_items WHERE order_id = p_order_id;
        UPDATE orders SET status = 'Cancelled' WHERE order_id = p_order_id;
        COMMIT;
        SELECT 'Hủy đơn hàng và hoàn kho thành công!' AS message;
    END IF;
END //
DELIMITER ;

-- Test thanh toán đơn hàng số 1
CALL sp_pay_order(1, 'Chuyen khoan Ngan hang');

-- Test hủy đơn hàng số 2
CALL sp_cancel_order(2);

SELECT * FROM orders;
SELECT * FROM payments;
SELECT * FROM inventory;
