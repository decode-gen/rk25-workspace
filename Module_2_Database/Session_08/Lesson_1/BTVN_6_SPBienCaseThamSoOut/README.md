# BTVN 6: Biến + CASE + Tham số OUT (Session 08)

## 1. Mục tiêu
- Hiểu cách sử dụng tham số đầu ra (OUT parameter) để trả dữ liệu
- Biết dùng cú pháp CASE - WHEN rẽ nhánh trong Stored Procedure

## 2. Mô tả & Yêu cầu
- Bảng students: student_id, full_name, gpa
- Tạo Stored Procedure sp_classify_student(IN p_gpa, OUT p_rank)
- Quy ước: >= 8.0 (Giỏi), 6.5-8.0 (Khá), 5.0-6.5 (Trung bình), < 5.0 (Yếu)
- Gán kết quả vào tham số OUT p_rank và kiểm tra bằng biến session @rank
