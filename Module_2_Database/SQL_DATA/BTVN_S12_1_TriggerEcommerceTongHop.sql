-- =============================================================================
-- BTVN Session 12 - Bài 1: Luyện tập các loại Trigger với CSDL Ecommerce
-- Mục tiêu: Triển khai trọn bộ 6 Trigger (BEFORE/AFTER cho INSERT/UPDATE/DELETE)
-- =============================================================================

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE inventory (
    product_id INT PRIMARY KEY,
    stock INT NOT NULL CHECK (stock >= 0),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    total_amount DECIMAL(12,2) DEFAULT 0.00,
    status VARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Dữ liệu mẫu
INSERT INTO customers (customer_name) VALUES ('Nguyen Van A');
INSERT INTO products (product_name, price) VALUES ('iPhone 15', 20000000.00), ('AirPods Pro', 5000000.00);
INSERT INTO inventory (product_id, stock) VALUES (1, 10), (2, 20);
INSERT INTO orders (customer_id, status) VALUES (1, 'Pending');

-- 1. Trigger BEFORE INSERT on order_items: Kiểm tra tồn kho
DELIMITER //
CREATE TRIGGER trg_before_insert_order_items
BEFORE INSERT ON order_items
FOR EACH ROW
BEGIN
    DECLARE v_stock INT;
    SELECT stock INTO v_stock FROM inventory WHERE product_id = NEW.product_id;
    IF NEW.quantity > v_stock THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Kho không đủ hàng để thêm vào đơn!';
    END IF;
END //

-- 2. Trigger AFTER INSERT on order_items: Tự động cộng total_amount trong orders
CREATE TRIGGER trg_after_insert_order_items
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    UPDATE orders 
    SET total_amount = total_amount + (NEW.quantity * NEW.price)
    WHERE order_id = NEW.order_id;
END //

-- 3. Trigger BEFORE UPDATE on order_items: Kiểm tra tồn kho khi tăng số lượng
CREATE TRIGGER trg_before_update_order_items
BEFORE UPDATE ON order_items
FOR EACH ROW
BEGIN
    DECLARE v_stock INT;
    SELECT stock INTO v_stock FROM inventory WHERE product_id = NEW.product_id;
    IF (NEW.quantity - OLD.quantity) > v_stock THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Số lượng cập nhật vượt quá tồn kho hiện có!';
    END IF;
END //

-- 4. Trigger AFTER UPDATE on order_items: Cập nhật lại total_amount của orders
CREATE TRIGGER trg_after_update_order_items
AFTER UPDATE ON order_items
FOR EACH ROW
BEGIN
    UPDATE orders 
    SET total_amount = total_amount - (OLD.quantity * OLD.price) + (NEW.quantity * NEW.price)
    WHERE order_id = NEW.order_id;
END //

-- 5. Trigger BEFORE DELETE on orders: Chặn xóa đơn hàng đã thanh toán (Completed)
CREATE TRIGGER trg_before_delete_orders
BEFORE DELETE ON orders
FOR EACH ROW
BEGIN
    IF OLD.status = 'Completed' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Không thể xóa đơn hàng đã hoàn tất (Completed)!';
    END IF;
END //

-- 6. Trigger AFTER DELETE on order_items: Hoàn trả số lượng vào inventory
CREATE TRIGGER trg_after_delete_order_items
AFTER DELETE ON order_items
FOR EACH ROW
BEGIN
    UPDATE inventory 
    SET stock = stock + OLD.quantity 
    WHERE product_id = OLD.product_id;
END //
DELIMITER ;

-- Kiểm thử thêm sản phẩm vào đơn hàng
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (1, 1, 2, 20000000.00);
SELECT * FROM orders WHERE order_id = 1;
