-- =============================================================================
-- BTVN Session 10 - Bài 6: Kiểm Tra Tồn Kho Trước Khi Thêm Vào Giỏ Hàng (BEFORE INSERT)
-- Mục tiêu: Dùng BEFORE INSERT kiểm tra NEW.quantity > stock kho và ném ngoại lệ
-- =============================================================================

DROP TABLE IF EXISTS cart_items;
DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE cart_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Khởi tạo sản phẩm mẫu: iPhone 15 tồn kho 5 chiếc
INSERT INTO Products (product_name, quantity, price) VALUES
('iPhone 15', 5, 21000000.00),
('Samsung S24 Ultra', 8, 26000000.00);

-- Tạo Trigger before_cart_add
DROP TRIGGER IF EXISTS before_cart_add;
DELIMITER //
CREATE TRIGGER before_cart_add
BEFORE INSERT ON cart_items
FOR EACH ROW
BEGIN
    DECLARE v_stock INT DEFAULT 0;
    
    -- Lấy số lượng tồn kho của sản phẩm đang được thêm vào giỏ
    SELECT quantity INTO v_stock
    FROM Products
    WHERE product_id = NEW.product_id;
    
    -- Kiểm tra nếu số lượng đặt mua vượt quá tồn kho
    IF NEW.quantity > v_stock THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi nghiệp vụ: Số lượng hàng trong kho không đủ để thêm vào giỏ!';
    END IF;
END //
DELIMITER ;

-- Test 1: Thêm vào giỏ hàng số lượng 2 (Hợp lệ vì 2 <= 5 tồn kho) -> Thành công
INSERT INTO cart_items (product_id, quantity) VALUES (1, 2);

-- Test 2: Thử thêm vào giỏ hàng số lượng 10 (Không hợp lệ vì 10 > 5 tồn kho) -> Bị chặn
-- INSERT INTO cart_items (product_id, quantity) VALUES (1, 10);

-- Kiểm tra các mục trong giỏ hàng
SELECT * FROM cart_items;
