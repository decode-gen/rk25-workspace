-- =============================================================================
-- BTVN Session 09 - Bài 2: Tạo danh sách liên lạc rút gọn (View)
-- Mục tiêu: Tạo view_customer_contact cho Marketing (ẩn địa chỉ chi tiết)
-- =============================================================================

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    address VARCHAR(255) NOT NULL
);

INSERT INTO customers (customer_name, email, phone, address) VALUES
('Nguyen Van An', 'an.nguyen@email.com', '0901234567', 'So 12 Ngo 45 Pho Hue, Hanoi'),
('Tran Thi Bich', 'bich.tran@email.com', '0912345678', 'Tang 5 Chung cu Sky, Danang'),
('Le Hoang Nam', 'nam.le@email.com', '0987654321', 'Can ho 12B Landmark 81, Saigon'),
('Pham Minh Tuan', 'tuan.pham@email.com', '0977889900', 'So 88 Duong 30/4, Can Tho');

-- Tạo View danh sách liên lạc: chỉ hiển thị customer_id, customer_name, email, phone
DROP VIEW IF EXISTS view_customer_contact;
CREATE VIEW view_customer_contact AS
SELECT customer_id, customer_name, email, phone
FROM customers;

-- Kiểm tra kết quả truy vấn qua View
SELECT * FROM view_customer_contact;
