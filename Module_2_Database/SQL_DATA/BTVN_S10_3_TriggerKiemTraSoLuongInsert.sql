-- =============================================================================
-- BTVN Session 10 - Bài 3: Tự động kiểm tra số lượng sản phẩm trước khi insert (BEFORE INSERT)
-- Mục tiêu: Chặn insert vào bảng Products nếu quantity < 0 dùng SIGNAL SQLSTATE
-- =============================================================================

DROP TABLE IF EXISTS Products;
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

-- Tạo Trigger BeforeInsertProduct
DROP TRIGGER IF EXISTS BeforeInsertProduct;
DELIMITER //
CREATE TRIGGER BeforeInsertProduct
BEFORE INSERT ON Products
FOR EACH ROW
BEGIN
    IF NEW.quantity < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi nghiệp vụ: Số lượng sản phẩm thêm mới không được nhỏ hơn 0!';
    END IF;
END //
DELIMITER ;

-- Test 1: Thêm sản phẩm với số lượng hợp lệ (quantity = 12 -> Thành công)
INSERT INTO Products (product_name, quantity, price) VALUES ('Ban phim Aula F75', 12, 650000.00);

-- Test 2: Thêm sản phẩm với số lượng âm (quantity = -5 -> Bị chặn và thông báo lỗi)
-- INSERT INTO Products (product_name, quantity, price) VALUES ('Chuot loi ton kho', -5, 100000.00);

-- Kiểm tra danh sách bảng Products
SELECT * FROM Products;
