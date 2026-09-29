-- =============================================================================
-- BTVN Session 07 - Bài 1: Làm quen với View (Một bảng)
-- Mục tiêu: Tạo VIEW v_student_basic ẩn thông tin bảo mật (năm sinh, địa chỉ)
-- =============================================================================

CREATE TABLE students (
    student_id VARCHAR(20) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    birth_year INT,
    class_name VARCHAR(50),
    address VARCHAR(200)
);

INSERT INTO students (student_id, full_name, birth_year, class_name, address) VALUES
('SV001', 'Nguyen Van An', 2004, 'JV2403', 'Hanoi'),
('SV002', 'Tran Thi Bich', 2005, 'JV2403', 'Danang'),
('SV003', 'Le Hoang Nam', 2004, 'JV2405', 'Saigon');

-- Yêu cầu: Tạo VIEW v_student_basic chỉ chứa mã sinh viên, họ tên, lớp học
CREATE VIEW v_student_basic AS
SELECT student_id, full_name, class_name
FROM students;

-- Kiểm tra kết quả truy vấn từ View
SELECT * FROM v_student_basic;
