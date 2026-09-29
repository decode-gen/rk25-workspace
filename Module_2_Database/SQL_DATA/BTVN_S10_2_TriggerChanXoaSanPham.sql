-- =============================================================================
-- BTVN Session 10 - Bài 2: Không cho phép xóa sản phẩm theo điều kiện (Trigger BEFORE DELETE)
-- Mục tiêu: Dùng SIGNAL SQLSTATE chặn xóa sản phẩm nếu tồn kho quantity > 10
-- =============================================================================

DROP TABLE IF EXISTS InventoryChanges;
DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    price DECIMAL(10,2) NOT NULL
);

INSERT INTO Products (product_name, quantity, price) VALUES
('Tai nghe Sony (Ton nhieu)', 25, 1200000.00),
('Op lung dien thoai (Ton it)', 4, 150000.00),
('Cap sac Type-C (Ton nhieu)', 15, 200000.00);

-- Tạo Trigger BeforeProductDelete
DROP TRIGGER IF EXISTS BeforeProductDelete;
DELIMITER //
CREATE TRIGGER BeforeProductDelete
BEFORE DELETE ON Products
FOR EACH ROW
BEGIN
    IF OLD.quantity > 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi nghiệp vụ: Không được phép xóa sản phẩm có tồn kho lớn hơn 10!';
    END IF;
END //
DELIMITER ;

-- Test 1: Xóa sản phẩm có quantity = 4 (Hợp lệ -> Xóa thành công)
DELETE FROM Products WHERE product_id = 2;

-- Test 2: Thử xóa sản phẩm có quantity = 25 (Không hợp lệ -> Bị chặn và ném ngoại lệ 45000)
-- DELETE FROM Products WHERE product_id = 1;

-- Kiểm tra lại bảng Products
SELECT * FROM Products;
