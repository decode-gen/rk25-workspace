-- =============================================================================
-- BTVN Session 08 - Bài 5: Stored Procedure sử dụng nhiều tham số và IF
-- Mục tiêu: Tạo sp_check_employee_income phân loại thu nhập (>=15tr cao, 8-15tr tb, <8tr thap)
-- =============================================================================

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    department VARCHAR(50) NOT NULL
);

INSERT INTO employees (full_name, salary, department) VALUES
('Nguyen Van An', 18500000.00, 'Ky Thuat'),
('Tran Thi Mai', 12000000.00, 'Ke Toan'),
('Le Quoc Huy', 7500000.00, 'Hanh Chinh'),
('Hoang Minh Duc', 15000000.00, 'Kinh Doanh');

-- Tạo Stored Procedure nhận nhiều tham số kết hợp IF - ELSEIF - ELSE
DROP PROCEDURE IF EXISTS sp_check_employee_income;
DELIMITER //
CREATE PROCEDURE sp_check_employee_income(
    IN p_name VARCHAR(100),
    IN p_salary DECIMAL(10,2)
)
BEGIN
    DECLARE v_income_level VARCHAR(50);
    
    IF p_salary >= 15000000.00 THEN
        SET v_income_level = 'Thu nhập cao';
    ELSEIF p_salary >= 8000000.00 THEN
        SET v_income_level = 'Thu nhập trung bình';
    ELSE
        SET v_income_level = 'Thu nhập thấp';
    END IF;
    
    -- Hiển thị kết quả ra màn hình
    SELECT p_name AS employee_name, p_salary AS salary, v_income_level AS income_level;
END //
DELIMITER ;

-- Kiểm thử các phân loại thu nhập
CALL sp_check_employee_income('Nguyen Van An', 18500000.00);
CALL sp_check_employee_income('Tran Thi Mai', 12000000.00);
CALL sp_check_employee_income('Le Quoc Huy', 7500000.00);
