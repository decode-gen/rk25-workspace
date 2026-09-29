-- =============================================================================
-- BTVN Session 07 - Bài 5: View phục vụ phân quyền truy cập
-- Mục tiêu: Tạo VIEW v_employee_public ẩn các cột nhạy cảm (lương, CMND)
-- =============================================================================

CREATE TABLE employees (
    employee_id VARCHAR(20) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    department VARCHAR(100) NOT NULL,
    salary DECIMAL(12,2) NOT NULL,
    identity_card VARCHAR(20) NOT NULL
);

INSERT INTO employees VALUES 
('EMP01', 'Nguyen Van Thang', 'P.Hanh Chinh', 12000000.00, '001200012345'),
('EMP02', 'Le Thi Ngoc Anh', 'P.Ke Toan', 16000000.00, '001200054321'),
('EMP03', 'Vu Hong Son', 'P.IT He Thong', 25000000.00, '001200099887');

-- Yêu cầu: Tạo VIEW v_employee_public chỉ hiển thị: mã nhân viên, họ tên, phòng ban
CREATE VIEW v_employee_public AS
SELECT employee_id, full_name, department
FROM employees;

-- Nhân sự phòng ban khác chỉ được phép xem qua View an toàn
SELECT * FROM v_employee_public;
