-- =============================================================================
-- BTVN Session 07 - Bài 4: Index kết hợp (Nhiều cột)
-- Mục tiêu: Tạo INDEX kết hợp (category, price) cho bảng products
-- =============================================================================

CREATE TABLE products (
    product_id VARCHAR(20) PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(100) NOT NULL,
    price DECIMAL(12,2) NOT NULL
);

INSERT INTO products VALUES 
('P01', 'Ban phim co RK84', 'Ban Phim', 1200000.00),
('P02', 'Ban phim custom Keychron', 'Ban Phim', 2500000.00),
('P03', 'Chuot gaming Logitech G502', 'Chuot', 1450000.00),
('P04', 'Chuot van phong Logitech B100', 'Chuot', 120000.00);

-- Yêu cầu: Tạo INDEX kết hợp 2 cột: category và price
CREATE INDEX idx_products_category_price ON products(category, price);

-- Kiểm tra truy vấn kết hợp lọc danh mục và giá bán
SELECT * FROM products WHERE category = 'Ban Phim' AND price <= 2000000.00;
