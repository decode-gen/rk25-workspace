# BTVN 5: Ứng dụng Transaction trong quản trị nhân sự (Session 12)

## 1. Mục tiêu
- Vận dụng Stored Procedure kết hợp Transaction quản lý nhân sự
- Đảm bảo toàn vẹn dữ liệu khi tăng lương hoặc xóa nhân viên

## 2. Mô tả & Yêu cầu
- Stored Procedure IncreaseSalary(emp_id, new_salary, reason): Kiểm tra nhân viên tồn tại, cập nhật lương mới, lưu lịch sử vào salary_history, COMMIT
- Stored Procedure DeleteEmployee(emp_id): Xóa lương và nhân viên, nhưng bảo toàn lịch sử salary_history phục vụ đối soát, COMMIT
