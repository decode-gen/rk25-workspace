-- =============================================================================
-- BTVN Session 10 - Bài 4: Trigger AFTER UPDATE – Ghi nhật ký thay đổi lương (Salary Log)
-- Mục tiêu: Tự động ghi lại old_salary, new_salary vào salary_log khi đổi lương nhân viên
-- =============================================================================

DROP TABLE IF EXISTS salary_log;
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15) NOT NULL
);

CREATE TABLE salary_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    old_salary DECIMAL(10,2) NOT NULL,
    new_salary DECIMAL(10,2) NOT NULL,
    change_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);

-- Chèn 10 bản ghi mẫu cho bảng employees
INSERT INTO employees (first_name, last_name, salary, email, phone_number) VALUES
('An', 'Nguyen', 12000000.00, 'an.nguyen@company.com', '0901000001'),
('Binh', 'Tran', 15000000.00, 'binh.tran@company.com', '0901000002'),
('Chau', 'Le', 9500000.00, 'chau.le@company.com', '0901000003'),
('Dung', 'Pham', 18000000.00, 'dung.pham@company.com', '0901000004'),
('Giang', 'Hoang', 11000000.00, 'giang.hoang@company.com', '0901000005'),
('Huong', 'Vu', 13500000.00, 'huong.vu@company.com', '0901000006'),
('Khanh', 'Do', 8500000.00, 'khanh.do@company.com', '0901000007'),
('Lam', 'Bui', 21000000.00, 'lam.bui@company.com', '0901000008'),
('Minh', 'Dinh', 16000000.00, 'minh.dinh@company.com', '0901000009'),
('Nam', 'Ngo', 14000000.00, 'nam.ngo@company.com', '0901000010');

-- Tạo Trigger trg_after_update_salary
DROP TRIGGER IF EXISTS trg_after_update_salary;
DELIMITER //
CREATE TRIGGER trg_after_update_salary
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO salary_log (employee_id, old_salary, new_salary, change_date)
        VALUES (OLD.id, OLD.salary, NEW.salary, NOW());
    END IF;
END //
DELIMITER ;

-- Kiểm thử: Cập nhật tăng lương cho nhân viên An và Binh
UPDATE employees SET salary = 14000000.00 WHERE id = 1;
UPDATE employees SET salary = 17500000.00 WHERE id = 2;

-- Cập nhật nhưng chỉ đổi số điện thoại (không đổi lương) -> Không ghi log
UPDATE employees SET phone_number = '0988999888' WHERE id = 3;

-- Xem bảng lịch sử thay đổi lương
SELECT * FROM salary_log;
