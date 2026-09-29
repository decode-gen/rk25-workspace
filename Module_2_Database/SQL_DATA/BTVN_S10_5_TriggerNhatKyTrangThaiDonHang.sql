-- =============================================================================
-- BTVN Session 10 - Bài 5: Tạo Trigger Ghi Nhật Ký Thay Đổi Trạng Thái Đơn Hàng
-- Mục tiêu: So sánh OLD.status <> NEW.status để ghi log timeline lịch sử đơn hàng
-- =============================================================================

DROP TABLE IF EXISTS order_logs;
DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL
);

CREATE TABLE order_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    old_status VARCHAR(50) NOT NULL,
    new_status VARCHAR(50) NOT NULL,
    log_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- Thêm đơn hàng ban đầu với trạng thái 'Pending'
INSERT INTO orders (customer_name, total_amount, status) VALUES
('Nguyen Van An', 3500000.00, 'Pending'),
('Tran Thi Mai', 1200000.00, 'Pending');

-- Tạo Trigger after_order_status_update
DROP TRIGGER IF EXISTS after_order_status_update;
DELIMITER //
CREATE TRIGGER after_order_status_update
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
    IF OLD.status <> NEW.status THEN
        INSERT INTO order_logs (order_id, old_status, new_status, log_date)
        VALUES (OLD.id, OLD.status, NEW.status, CURRENT_TIMESTAMP);
    END IF;
END //
DELIMITER ;

-- Kiểm thử 1: Đổi trạng thái đơn hàng 1 sang 'Shipping' -> Ghi nhận log
UPDATE orders SET status = 'Shipping' WHERE id = 1;

-- Kiểm thử 2: Sửa tên khách hàng nhưng giữ nguyên trạng thái 'Shipping' -> KHÔNG ghi log
UPDATE orders SET customer_name = 'Nguyen Van An (VIP)' WHERE id = 1;

-- Kiểm thử 3: Chuyển đơn hàng 1 sang 'Completed' -> Ghi nhận log lần 2
UPDATE orders SET status = 'Completed' WHERE id = 1;

-- Xem nhật ký timeline đơn hàng
SELECT * FROM order_logs;
