-- =============================================================================
-- BTVN Session 07 - Bài 3: Làm quen với Index (Một cột)
-- Mục tiêu: Tạo INDEX cho cột department (Phòng ban) trong bảng employees
-- =============================================================================

CREATE TABLE employees (
    employee_id VARCHAR(20) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    department VARCHAR(100) NOT NULL,
    salary DECIMAL(12,2) NOT NULL
);

INSERT INTO employees VALUES 
('NV01', 'Doan Minh Quan', 'Phong Ky Thuat', 18000000.00),
('NV02', 'Pham Thi Thu', 'Phong Nhan Su', 14000000.00),
('NV03', 'Bui Tuan Kiet', 'Phong Ky Thuat', 22000000.00),
('NV04', 'Nguyen Ha My', 'Phong Kinh Doanh', 16500000.00);

-- Yêu cầu: Tạo INDEX đơn cho cột department để tăng tốc độ tìm kiếm
CREATE INDEX idx_employees_department ON employees(department);

-- Kiểm tra truy vấn tận dụng Index
SELECT * FROM employees WHERE department = 'Phong Ky Thuat';
