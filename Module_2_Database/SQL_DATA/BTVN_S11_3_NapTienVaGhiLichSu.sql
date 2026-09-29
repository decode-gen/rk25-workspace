-- =============================================================================
-- BTVN Session 11 - Bài 3: Giao dịch Nạp tiền và Ghi lịch sử (All-or-Nothing)
-- Mục tiêu: Quản lý tính nguyên tử (Atomicity), ghi nhận đồng thời số dư và log giao dịch
-- =============================================================================

DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS accounts;

CREATE TABLE accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    balance DECIMAL(12,2) NOT NULL DEFAULT 0.00
);

CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    log_message VARCHAR(255) NOT NULL,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

INSERT INTO accounts (customer_name, balance) VALUES
('Nguyen Van An', 1000000.00),
('Tran Thi Mai', 500000.00),
('Le Hoang Nam', 200000.00); -- ID = 3

-- Tạo Stored Procedure nạp tiền kèm ghi lịch sử giao dịch
DROP PROCEDURE IF EXISTS deposit_with_logging;
DELIMITER //
CREATE PROCEDURE deposit_with_logging(
    IN p_account_id INT,
    IN p_amount DECIMAL(12,2)
)
BEGIN
    -- Khai báo Exit Handler: Nếu có bất kỳ lỗi SQL nào xảy ra, tự động ROLLBACK
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Giao dịch thất bại! Đã rollback toàn bộ dữ liệu.' AS error_status;
    END;

    -- Bắt đầu Transaction
    START TRANSACTION;
    
    -- Bước 1: Cập nhật cộng thêm tiền vào tài khoản
    UPDATE accounts 
    SET balance = balance + p_amount 
    WHERE account_id = p_account_id;
    
    -- Bước 2: Thêm một dòng ghi nhận vào bảng transactions
    INSERT INTO transactions (account_id, amount, log_message, transaction_date)
    VALUES (p_account_id, p_amount, 'Nạp tiền vào tài khoản', NOW());
    
    -- Cả 2 bước thành công -> COMMIT
    COMMIT;
    SELECT 'Nạp tiền và ghi nhận lịch sử thành công!' AS status;
END //
DELIMITER ;

-- Kiểm thử: Nạp 1.000.000 VNĐ cho tài khoản ID = 3
CALL deposit_with_logging(3, 1000000.00);

-- Kiểm tra lại bảng accounts và bảng transactions
SELECT * FROM accounts WHERE account_id = 3;
SELECT * FROM transactions WHERE account_id = 3;
