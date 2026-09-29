-- =============================================================================
-- BTVN Session 11 - Bài 4: Chuyển Tiền Giữa Hai Tài Khoản (Money Transfer Transaction)
-- Mục tiêu: Đảm bảo tính nhất quán (Consistency) khi chuyển tiền giữa 2 tài khoản ngân hàng
-- =============================================================================

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    balance DECIMAL(12,2) NOT NULL DEFAULT 0.00
);

INSERT INTO accounts (account_id, customer_name, balance) VALUES
(4, 'Tai khoan A (Nguoi gui)', 2000000.00),
(5, 'Tai khoan B (Nguoi nhan)', 0.00);

-- Tạo Stored Procedure transfer_money
DROP PROCEDURE IF EXISTS transfer_money;
DELIMITER //
CREATE PROCEDURE transfer_money(
    IN p_sender_id INT,
    IN p_receiver_id INT,
    IN p_amount DECIMAL(12,2)
)
BEGIN
    DECLARE v_sender_balance DECIMAL(12,2);
    
    -- Tự động ROLLBACK khi có lỗi hệ thống bất ngờ
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Hệ thống gặp sự cố, giao dịch chuyển tiền bị hủy bỏ!' AS error_msg;
    END;

    START TRANSACTION;
    
    -- Kiểm tra số dư người gửi
    SELECT balance INTO v_sender_balance 
    FROM accounts 
    WHERE account_id = p_sender_id;
    
    IF v_sender_balance IS NULL OR v_sender_balance < p_amount THEN
        ROLLBACK;
        SELECT 'Số dư người gửi không đủ hoặc tài khoản không tồn tại!' AS message;
    ELSE
        -- 1. Trừ tiền người gửi
        UPDATE accounts 
        SET balance = balance - p_amount 
        WHERE account_id = p_sender_id;
        
        -- 2. Cộng tiền người nhận
        UPDATE accounts 
        SET balance = balance + p_amount 
        WHERE account_id = p_receiver_id;
        
        COMMIT;
        SELECT 'Chuyển tiền thành công!' AS message;
    END IF;
END //
DELIMITER ;

-- Kiểm thử: Chuyển 300.000 VNĐ từ ID 4 sang ID 5
CALL transfer_money(4, 5, 300000.00);

-- Kiểm tra lại số dư cả hai tài khoản
SELECT * FROM accounts WHERE account_id IN (4, 5);
