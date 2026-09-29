# BTVN 3: Sử dụng biến trong Stored Procedure (Session 08)

## 1. Mục tiêu
- Hiểu cách khai báo biến cục bộ bằng cú pháp DECLARE
- Biết gán giá trị từ câu lệnh SELECT aggregate INTO biến
- Xuất giá trị biến ra màn hình

## 2. Mô tả & Yêu cầu
- Bảng employees: employee_id, full_name, salary
- Tạo Stored Procedure sp_get_avg_salary
- Khai báo biến v_avg_salary lưu mức lương trung bình
- Dùng SELECT AVG(salary) INTO v_avg_salary
- Hiển thị giá trị biến average_salary ra ngoài
