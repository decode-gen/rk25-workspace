-- =============================================================================
-- BTVN Session 07 - Bài 6: Index phục vụ tìm kiếm theo nhiều điều kiện
-- Mục tiêu: Tạo INDEX kết hợp (order_status, order_date) cho bảng orders
-- =============================================================================

CREATE TABLE orders (
    order_id VARCHAR(20) PRIMARY KEY,
    order_date DATE NOT NULL,
    order_status VARCHAR(50) NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL
);

INSERT INTO orders VALUES 
('ORD_101', '2026-09-01', 'Hoan tat', 4500000.00),
('ORD_102', '2026-09-02', 'Cho xu ly', 1200000.00),
('ORD_103', '2026-09-05', 'Hoan tat', 8900000.00),
('ORD_104', '2026-09-10', 'Da huy', 500000.00);

-- Yêu cầu: Tạo INDEX kết hợp 2 cột: order_status và order_date
CREATE INDEX idx_orders_status_date ON orders(order_status, order_date);

-- Kiểm tra truy vấn tìm kiếm đơn hàng hoàn tất theo khoảng thời gian
SELECT * FROM orders 
WHERE order_status = 'Hoan tat' AND order_date >= '2026-09-01';
