-- =============================================================================
-- BTVN Session 12 - Bài 4: Luyện tập Trigger trong quản trị nhân sự
-- Mục tiêu: Chuẩn hóa email nhân viên, tạo lương mặc định, tự tính giờ làm khi checkout
-- =============================================================================

DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL
);

CREATE TABLE salaries (
    salary_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT NOT NULL,
    base_salary DECIMAL(10,2) NOT NULL,
    bonus DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

CREATE TABLE attendance (
    att_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT NOT NULL,
    check_in_time DATETIME NOT NULL,
    check_out_time DATETIME NULL,
    total_hours DECIMAL(4,2) DEFAULT 0.00,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- 1. Trigger BEFORE INSERT on employees: Chuẩn hóa email @company.com
DELIMITER //
CREATE TRIGGER trg_employee_email_normalize
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.email NOT LIKE '%@company.com' THEN
        SET NEW.email = CONCAT(NEW.email, '@company.com');
    END IF;
END //

-- 2. Trigger AFTER INSERT on employees: Tự động tạo bản ghi lương cơ bản 10,000.00
CREATE TRIGGER trg_employee_default_salary
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO salaries (emp_id, base_salary, bonus)
    VALUES (NEW.emp_id, 10000.00, 0.00);
END //

-- 3. Trigger BEFORE UPDATE on attendance: Tự tính total_hours khi checkout
CREATE TRIGGER trg_attendance_calc_hours
BEFORE UPDATE ON attendance
FOR EACH ROW
BEGIN
    IF NEW.check_out_time IS NOT NULL AND OLD.check_out_time IS NULL THEN
        SET NEW.total_hours = ROUND(TIMESTAMPDIFF(MINUTE, OLD.check_in_time, NEW.check_out_time) / 60.0, 2);
    END IF;
END //
DELIMITER ;

-- Kiểm thử:
-- 1. Thêm nhân viên với email chưa có đuôi @company.com
INSERT INTO employees (full_name, email, department) VALUES ('Nguyen Van A', 'nguyenvana', 'IT');
SELECT * FROM employees;
SELECT * FROM salaries;

-- 2. Thêm chấm công và checkout
INSERT INTO attendance (emp_id, check_in_time) VALUES (1, '2026-09-29 08:00:00');
UPDATE attendance SET check_out_time = '2026-09-29 17:30:00' WHERE att_id = 1;
SELECT * FROM attendance;
