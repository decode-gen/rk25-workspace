-- =============================================================================
-- BTVN Session 10 - Bài 1: Ghi lại thay đổi số lượng sản phẩm (Trigger AFTER UPDATE)
-- Mục tiêu: Tự động ghi nhật ký vào InventoryChanges mỗi khi quantity trong Products thay đổi
-- =============================================================================

DROP TABLE IF EXISTS InventoryChanges;
DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE InventoryChanges (
    change_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    old_quantity INT NOT NULL,
    new_quantity INT NOT NULL,
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Products (product_name, quantity, price) VALUES
('iPhone 15 Pro', 10, 25000000.00),
('MacBook Air M2', 8, 23000000.00),
('Chuot Magic Mouse', 20, 1900000.00);

-- Tạo Trigger AfterProductUpdate
DROP TRIGGER IF EXISTS AfterProductUpdate;
DELIMITER //
CREATE TRIGGER AfterProductUpdate
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    IF OLD.quantity <> NEW.quantity THEN
        INSERT INTO InventoryChanges (product_id, old_quantity, new_quantity)
        VALUES (OLD.product_id, OLD.quantity, NEW.quantity);
    END IF;
END //
DELIMITER ;

-- Kiểm thử trigger: Cập nhật số lượng sản phẩm iPhone 15 Pro từ 10 xuống 7
UPDATE Products SET quantity = 7 WHERE product_id = 1;

-- Cập nhật sản phẩm khác nhưng chỉ sửa giá (không đổi quantity) -> Trigger không ghi log
UPDATE Products SET price = 22500000.00 WHERE product_id = 2;

-- Cập nhật tiếp số lượng sản phẩm MacBook Air M2 từ 8 lên 15
UPDATE Products SET quantity = 15 WHERE product_id = 2;

-- Xem bảng nhật ký InventoryChanges
SELECT * FROM InventoryChanges;
