-- =============================================================================
-- BTVN Session 12 - Bài 5: Ứng dụng Transaction trong quản trị nhân sự
-- Mục tiêu: Quản lý tăng lương (IncreaseSalary) và cho thôi việc (DeleteEmployee) an toàn
-- =============================================================================

DROP TABLE IF EXISTS salary_history;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL
);

CREATE TABLE salaries (
    salary_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

CREATE TABLE salary_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT NOT NULL,
    old_salary DECIMAL(10,2) NOT NULL,
    new_salary DECIMAL(10,2) NOT NULL,
    reason VARCHAR(255) NOT NULL,
    change_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO employees VALUES (1, 'Tran Van Nam', 'Phong Ke Toan'), (2, 'Le Thi Hoa', 'Phong Nhan Su');
INSERT INTO salaries VALUES (1, 1, 12000000.00), (2, 2, 15000000.00);

-- 1. Stored Procedure IncreaseSalary
DROP PROCEDURE IF EXISTS IncreaseSalary;
DELIMITER //
CREATE PROCEDURE IncreaseSalary(
    IN p_emp_id INT,
    IN p_new_salary DECIMAL(10,2),
    IN p_reason VARCHAR(255)
)
BEGIN
    DECLARE v_old_salary DECIMAL(10,2);
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Lỗi cập nhật tăng lương! Đã hủy bỏ giao dịch.' AS status;
    END;

    START TRANSACTION;
    
    SELECT salary INTO v_old_salary FROM salaries WHERE emp_id = p_emp_id;
    
    IF v_old_salary IS NULL THEN
        ROLLBACK;
        SELECT 'Nhân viên không tồn tại trong hệ thống!' AS message;
    ELSE
        -- Cập nhật lương mới
        UPDATE salaries SET salary = p_new_salary WHERE emp_id = p_emp_id;
        -- Ghi nhật ký lịch sử
        INSERT INTO salary_history (emp_id, old_salary, new_salary, reason)
        VALUES (p_emp_id, v_old_salary, p_new_salary, p_reason);
        COMMIT;
        SELECT 'Cập nhật tăng lương và lưu lịch sử thành công!' AS message;
    END IF;
END //

-- 2. Stored Procedure DeleteEmployee
CREATE PROCEDURE DeleteEmployee(
    IN p_emp_id INT
)
BEGIN
    DECLARE v_count INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Lỗi trong quá trình xóa nhân viên! Đã hủy bỏ.' AS status;
    END;

    START TRANSACTION;
    
    SELECT COUNT(*) INTO v_count FROM employees WHERE emp_id = p_emp_id;
    
    IF v_count = 0 THEN
        ROLLBACK;
        SELECT 'Không tìm thấy nhân viên cần xóa!' AS message;
    ELSE
        -- Xóa thông tin lương
        DELETE FROM salaries WHERE emp_id = p_emp_id;
        -- Xóa nhân viên khỏi bảng employees (lịch sử salary_history vẫn được bảo tồn để kiểm toán)
        DELETE FROM employees WHERE emp_id = p_emp_id;
        COMMIT;
        SELECT 'Xóa nhân viên và lương thành công! Lịch sử lương vẫn được bảo toàn.' AS message;
    END IF;
END //
DELIMITER ;

-- Test 1: Tăng lương cho nhân viên số 1
CALL IncreaseSalary(1, 16000000.00, 'Thăng chức Trưởng phòng');

-- Test 2: Xóa nhân viên số 2
CALL DeleteEmployee(2);

-- Kiểm tra kết quả
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM salary_history;
