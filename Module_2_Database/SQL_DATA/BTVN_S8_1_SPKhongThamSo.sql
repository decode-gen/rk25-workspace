-- =============================================================================
-- BTVN Session 08 - Bài 1: Stored Procedure không có tham số
-- Mục tiêu: Tạo thủ tục sp_get_all_students để lấy toàn bộ danh sách sinh viên
-- =============================================================================

DROP TABLE IF EXISTS students;
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    class_name VARCHAR(50) NOT NULL
);

INSERT INTO students (full_name, class_name) VALUES
('Nguyen Van An', 'JV2403'),
('Tran Thi Bich', 'JV2403'),
('Le Hoang Nam', 'JV2405'),
('Pham Minh Tuan', 'JV2405');

-- Tạo Stored Procedure không có tham số
DROP PROCEDURE IF EXISTS sp_get_all_students;
DELIMITER //
CREATE PROCEDURE sp_get_all_students()
BEGIN
    SELECT student_id, full_name, class_name FROM students;
END //
DELIMITER ;

-- Gọi thực thi Stored Procedure
CALL sp_get_all_students();
