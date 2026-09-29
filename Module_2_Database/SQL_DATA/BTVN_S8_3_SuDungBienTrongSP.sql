-- =============================================================================
-- BTVN Session 08 - Bài 3: Sử dụng biến trong Stored Procedure
-- Mục tiêu: Tạo thủ tục sp_get_avg_salary tính lương trung bình dùng DECLARE biến
-- =============================================================================

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    salary DECIMAL(10,2) NOT NULL
);

INSERT INTO employees (full_name, salary) VALUES
('Nguyen Van An', 12000000.00),
('Tran Thi Mai', 18000000.00),
('Le Quoc Huy', 9500000.00),
('Pham Thanh Huong', 15000000.00),
('Hoang Minh Duc', 8500000.00);

-- Tạo Stored Procedure sử dụng biến nội bộ
DROP PROCEDURE IF EXISTS sp_get_avg_salary;
DELIMITER //
CREATE PROCEDURE sp_get_avg_salary()
BEGIN
    -- Khai báo biến cục bộ lưu mức lương trung bình
    DECLARE v_avg_salary DECIMAL(10,2);
    
    -- Gán giá trị tính toán vào biến
    SELECT AVG(salary) INTO v_avg_salary FROM employees;
    
    -- Hiển thị giá trị biến ra màn hình
    SELECT v_avg_salary AS average_salary;
END //
DELIMITER ;

-- Gọi thực thi Stored Procedure
CALL sp_get_avg_salary();
