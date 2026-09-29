-- =============================================================================
-- BTVN Session 06 - Bài 3: Tìm kiếm sản phẩm nâng cao
-- Mục tiêu: BETWEEN, LIKE, GROUP BY, Aggregate functions (AVG, MIN), Subquery
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

INSERT INTO categories VALUES 
(1, 'Laptop & PC'),
(2, 'Phu kien thiet bi'),
(3, 'Thiet bi am thanh');

INSERT INTO products VALUES 
(201, 'Laptop Dell Latitude 7420 Pro', 18500000.00, 1),
(202, 'Laptop Macbook Air M2', 24900000.00, 1),
(203, 'Chuot Logitech MX Master 3S', 2200000.00, 2),
(204, 'Ban phim Bluetooth Mini', 650000.00, 2),
(205, 'Tai nghe Sony WH-1000XM5 Pro', 8490000.00, 3),
(206, 'Loa Bluetooth JBL Flip 6', 2690000.00, 3);

-- 1. Tìm các sản phẩm có giá nằm trong một khoảng cụ thể (từ 2.000.000 đến 10.000.000)
SELECT product_id, product_name, price 
FROM products 
WHERE price BETWEEN 2000000.00 AND 10000000.00;

-- 2. Tìm các sản phẩm có tên chứa một chuỗi ký tự nhất định ('Pro')
SELECT product_id, product_name, price 
FROM products 
WHERE product_name LIKE '%Pro%';

-- 3. Tính giá trung bình của sản phẩm cho mỗi danh mục
SELECT c.category_name, ROUND(AVG(p.price), 2) AS avg_category_price
FROM categories c
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name;

-- 4. Tìm những sản phẩm có giá cao hơn mức giá trung bình của toàn bộ sản phẩm
SELECT product_id, product_name, price 
FROM products 
WHERE price > (SELECT AVG(price) FROM products);

-- 5. Tìm sản phẩm có giá thấp nhất cho từng danh mục
SELECT c.category_name, p.product_name, p.price
FROM products p
JOIN categories c ON p.category_id = c.category_id
WHERE (p.category_id, p.price) IN (
    SELECT category_id, MIN(price)
    FROM products
    GROUP BY category_id
);
