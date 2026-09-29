-- =============================================================================
-- BTVN Session 08 - Bài 6: Stored Procedure sử dụng biến + CASE + Tham số OUT
-- Mục tiêu: Tạo sp_classify_student xếp loại học lực dựa trên GPA qua tham số OUT
-- =============================================================================

DROP TABLE IF EXISTS students;
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    gpa DECIMAL(3,1) NOT NULL
);

INSERT INTO students (full_name, gpa) VALUES
('Nguyen Van An', 8.5),
('Tran Thi Mai', 7.2),
('Le Quoc Huy', 5.8),
('Pham Minh Tuan', 4.3);

-- Tạo Stored Procedure với CASE và tham số OUT
DROP PROCEDURE IF EXISTS sp_classify_student;
DELIMITER //
CREATE PROCEDURE sp_classify_student(
    IN p_gpa DECIMAL(3,1),
    OUT p_rank VARCHAR(20)
)
BEGIN
    DECLARE v_rank VARCHAR(20);
    
    CASE 
        WHEN p_gpa >= 8.0 THEN SET v_rank = 'Giỏi';
        WHEN p_gpa >= 6.5 THEN SET v_rank = 'Khá';
        WHEN p_gpa >= 5.0 THEN SET v_rank = 'Trung bình';
        ELSE SET v_rank = 'Yếu';
    END CASE;
    
    SET p_rank = v_rank;
END //
DELIMITER ;

-- Kiểm thử gọi Procedure và lấy giá trị qua biến session
CALL sp_classify_student(8.5, @rank1);
CALL sp_classify_student(7.0, @rank2);
CALL sp_classify_student(4.5, @rank3);

SELECT @rank1 AS rank_8_5, @rank2 AS rank_7_0, @rank3 AS rank_4_5;
