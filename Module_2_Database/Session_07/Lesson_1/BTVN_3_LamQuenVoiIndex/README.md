# BTVN 3: Làm quen với Index (Một cột)

## 1. Mục tiêu
- Hiểu vai trò của INDEX trong việc tăng tốc độ tìm kiếm bản ghi
- Tạo Index đơn cho một cột thường xuyên dùng trong mệnh đề WHERE

## 2. Mô tả & Yêu cầu
- Bảng employees: employee_id, full_name, department, salary
- Cột department thường xuyên được tìm kiếm
- Tạo INDEX idx_employees_department cho cột department
