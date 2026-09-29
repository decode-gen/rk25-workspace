-- =============================================================================
-- BTVN Session 06 - Bài 1: Quản lý sản phẩm & danh mục
-- Mục tiêu: INSERT, UPDATE, DELETE, SELECT, ORDER BY, GROUP BY
-- =============================================================================

CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Khởi tạo danh mục mẫu
INSERT INTO categories (category_id, category_name) VALUES 
(1, 'Dien tu & Cong nghe'),
(2, 'Gia dung thong minh'),
(3, 'Thoi trang & Phu kien');

-- 1. Thêm 3 sản phẩm mới vào bảng products
INSERT INTO products (product_id, product_name, price, category_id) VALUES 
(101, 'Ban phim co RK Royal', 1250000.00, 1),
(102, 'Chuot gaming Logitech G', 890000.00, 1),
(103, 'Noi chien khong dau Philips', 2450000.00, 2),
(104, 'Ao khoac hoodie chong nuoc', 450000.00, 3);

-- 2. Cập nhật giá của một sản phẩm đã có (ví dụ: sản phẩm 101 tăng giá)
UPDATE products SET price = 1350000.00 WHERE product_id = 101;

-- 3. Xóa một sản phẩm (ví dụ: sản phẩm 104)
DELETE FROM products WHERE product_id = 104;

-- 4. Hiển thị tất cả sản phẩm, sắp xếp theo giá giảm dần
SELECT p.product_id, p.product_name, p.price, c.category_name 
FROM products p
LEFT JOIN categories c ON p.category_id = c.category_id
ORDER BY p.price DESC;

-- 5. Thống kê số lượng sản phẩm cho từng danh mục
SELECT c.category_name, COUNT(p.product_id) AS total_products
FROM categories c
LEFT JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name;
