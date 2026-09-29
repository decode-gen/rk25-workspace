-- =============================================================================
-- BTVN Session 11 - Bài 2: Tạo Stored Procedure Rút Tiền (Rollback khi số dư âm)
-- Mục tiêu: Kết hợp Transaction vào Stored Procedure, tự động ROLLBACK nếu số dư < 0
-- =============================================================================

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    balance DECIMAL(12,2) NOT NULL DEFAULT 0.00
);

INSERT INTO accounts (customer_name, balance) VALUES
('Nguyen Van An', 5000000.00),
('Tran Thi Mai', 300000.00); -- Tài khoản ID = 2 có 300.000đ

-- Tạo Stored Procedure withdraw_money
DROP PROCEDURE IF EXISTS withdraw_money;
DELIMITER //
CREATE PROCEDURE withdraw_money(
    IN p_account_id INT,
    IN p_amount DECIMAL(12,2)
)
BEGIN
    DECLARE v_current_balance DECIMAL(12,2);
    
    -- 1. Bắt đầu phiên giao dịch
    START TRANSACTION;
    
    -- 2. Thử trừ tiền trong tài khoản
    UPDATE accounts 
    SET balance = balance - p_amount 
    WHERE account_id = p_account_id;
    
    -- 3. Kiểm tra số dư sau khi trừ
    SELECT balance INTO v_current_balance 
    FROM accounts 
    WHERE account_id = p_account_id;
    
    -- 4. Điều kiện nghiệp vụ
    IF v_current_balance < 0 THEN
        -- Số dư âm -> Hủy bỏ mọi thay đổi
        ROLLBACK;
        SELECT 'Lỗi: Số dư không đủ để thực hiện rút tiền!' AS message, v_current_balance AS invalid_balance;
    ELSE
        -- Hợp lệ -> Lưu thay đổi
        COMMIT;
        SELECT 'Rút tiền thành công' AS message, v_current_balance AS remaining_balance;
    END IF;
END //
DELIMITER ;

-- Test 1 (Thất bại): Rút 500.000đ từ tài khoản có 300.000đ -> Bị ROLLBACK, tiền vẫn là 300.000đ
CALL withdraw_money(2, 500000.00);
SELECT * FROM accounts WHERE account_id = 2;

-- Test 2 (Thành công): Rút 100.000đ -> Thành công, số dư còn 200.000đ
CALL withdraw_money(2, 100000.00);
SELECT * FROM accounts WHERE account_id = 2;
