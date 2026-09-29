-- =============================================================================
-- BTVN Session 11 - Bài 5: Kiểm Tra & Bắt Lỗi Chuyển Tiền Nâng Cao
-- Mục tiêu: Kiểm tra toàn vẹn tài khoản người nhận, số tiền dương và bảo toàn số dư
-- =============================================================================

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    balance DECIMAL(12,2) NOT NULL DEFAULT 0.00
);

INSERT INTO accounts (account_id, customer_name, balance) VALUES
(4, 'Tai khoan A (Nguoi gui)', 2000000.00),
(5, 'Tai khoan B (Nguoi nhan)', 500000.00);

DROP PROCEDURE IF EXISTS transfer_money_advanced;
DELIMITER //
CREATE PROCEDURE transfer_money_advanced(
    IN p_sender_id INT,
    IN p_receiver_id INT,
    IN p_amount DECIMAL(12,2)
)
BEGIN
    DECLARE v_sender_balance DECIMAL(12,2);
    DECLARE v_receiver_count INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Lỗi ngoại lệ SQL! Giao dịch đã bị hoàn tác.' AS status;
    END;

    START TRANSACTION;
    
    -- Kiểm tra số tiền chuyển phải lớn hơn 0
    IF p_amount <= 0 THEN
        ROLLBACK;
        SELECT 'Số tiền chuyển khoản phải lớn hơn 0!' AS message;
    ELSE
        -- Kiểm tra tài khoản nhận có tồn tại không
        SELECT COUNT(*) INTO v_receiver_count FROM accounts WHERE account_id = p_receiver_id;
        SELECT balance INTO v_sender_balance FROM accounts WHERE account_id = p_sender_id;
        
        IF v_receiver_count = 0 THEN
            ROLLBACK;
            SELECT 'Tài khoản người nhận không tồn tại!' AS message;
        ELSEIF v_sender_balance IS NULL OR v_sender_balance < p_amount THEN
            ROLLBACK;
            SELECT 'Tài khoản người gửi không đủ số dư khả dụng!' AS message;
        ELSE
            -- Thực thi chuyển khoản
            UPDATE accounts SET balance = balance - p_amount WHERE account_id = p_sender_id;
            UPDATE accounts SET balance = balance + p_amount WHERE account_id = p_receiver_id;
            COMMIT;
            SELECT 'Chuyển khoản liên tài khoản thành công!' AS message;
        END IF;
    END IF;
END //
DELIMITER ;

-- Test chuyển hợp lệ
CALL transfer_money_advanced(4, 5, 500000.00);
SELECT * FROM accounts WHERE account_id IN (4, 5);

-- Test chuyển vượt số dư (Bị chặn an toàn)
CALL transfer_money_advanced(4, 5, 5000000.00);
