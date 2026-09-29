-- =============================================================================
-- BTVN Session 09 - Bài 6: Thủ Tục Thêm Mới Đơn Hàng (Kiểm tra tồn kho & OUT Parameter)
-- Mục tiêu: Tạo sp add_order kiểm tra số lượng tồn kho trước khi trừ kho và tạo đơn
-- =============================================================================

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    price DECIMAL(12,2) NOT NULL,
    stock INT NOT NULL CHECK (stock >= 0)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO customers (customer_name) VALUES ('Nguyen Van A'), ('Tran Thi B');
INSERT INTO products (product_name, price, stock) VALUES 
('iPhone 15 Pro Max', 30000000.00, 5),
('Chuot logitech G102', 400000.00, 20);

-- Tạo Stored Procedure thêm đơn hàng có OUT message
DROP PROCEDURE IF EXISTS add_order;
DELIMITER //
CREATE PROCEDURE add_order(
    IN _customer_id INT,
    IN _product_id INT,
    IN _quantity INT,
    OUT _message VARCHAR(255)
)
BEGIN
    DECLARE v_stock INT DEFAULT 0;
    DECLARE v_price DECIMAL(12,2) DEFAULT 0.00;
    
    -- Lấy thông tin tồn kho và giá hiện tại của sản phẩm
    SELECT stock, price INTO v_stock, v_price
    FROM products
    WHERE product_id = _product_id;
    
    -- Kiểm tra điều kiện tồn kho
    IF v_stock IS NULL OR v_stock < _quantity THEN
        SET _message = 'Không đủ số lượng sản phẩm để đặt hàng.';
    ELSE
        -- Đủ tồn kho: Trừ số lượng kho
        UPDATE products 
        SET stock = stock - _quantity 
        WHERE product_id = _product_id;
        
        -- Tạo đơn hàng mới
        INSERT INTO orders (customer_id, product_id, quantity, total_amount)
        VALUES (_customer_id, _product_id, _quantity, v_price * _quantity);
        
        SET _message = 'Thêm đơn hàng thành công!';
    END IF;
END //
DELIMITER ;

-- Test trường hợp 1: Đủ hàng (mua 2 chiếc iPhone 15)
CALL add_order(1, 1, 2, @msg1);
SELECT @msg1 AS ket_qua_test_1;

-- Test trường hợp 2: Không đủ hàng (mua 10 chiếc trong khi kho chỉ còn 3)
CALL add_order(2, 1, 10, @msg2);
SELECT @msg2 AS ket_qua_test_2;

-- Kiểm tra lại tồn kho và danh sách đơn hàng
SELECT * FROM products;
SELECT * FROM orders;
