-- =============================================================================
-- BTVN Session 11 - Bài 1: Gửi tiền vào tài khoản (Transaction Cơ Bản)
-- Mục tiêu: Nắm vững START TRANSACTION và COMMIT trong thao tác cập nhật dữ liệu an toàn
-- =============================================================================

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    balance DECIMAL(12,2) NOT NULL DEFAULT 0.00
);

-- Thêm 10 tài khoản mẫu vào bảng
INSERT INTO accounts (customer_name, balance) VALUES
('Nguyen Van An', 5000000.00),
('Tran Thi Mai', 300000.00),
('Le Hoang Nam', 1200000.00),
('Pham Minh Tuan', 2000000.00),
('Hoang Minh Duc', 0.00),
('Vu Thi Huong', 7500000.00),
('Doan Quoc Huy', 4200000.00),
('Bui Thi Lan', 1500000.00),
('Dinh Cong Son', 8900000.00),
('Ngo Bao Chau', 10500000.00);

-- Kiểm tra số dư tài khoản ID = 1 trước khi gửi tiền
SELECT account_id, customer_name, balance AS balance_before 
FROM accounts WHERE account_id = 1;

-- Bắt đầu giao dịch an toàn (START TRANSACTION)
START TRANSACTION;

-- Cộng thêm 1.000.000 VNĐ vào tài khoản có account_id = 1
UPDATE accounts 
SET balance = balance + 1000000.00 
WHERE account_id = 1;

-- Xác nhận lưu vĩnh viễn thay đổi vào CSDL
COMMIT;

-- Kiểm tra số dư sau khi giao dịch hoàn tất
SELECT account_id, customer_name, balance AS balance_after 
FROM accounts WHERE account_id = 1;
