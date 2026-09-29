# BTVN 4: Luyện tập Trigger trong quản trị nhân sự (Session 12)

## 1. Mục tiêu
- Vận dụng TRIGGER xử lý tình huống thực tế trong nhân sự
- Chuẩn hóa email, tự sinh mức lương và tính giờ làm

## 2. Mô tả & Yêu cầu
- Bảng employees, salaries, attendance
- Trigger BEFORE INSERT on employees: Tự động gắn đuôi @company.com nếu chưa có
- Trigger AFTER INSERT on employees: Tự tạo bản ghi lương mặc định 10,000.00
- Trigger BEFORE UPDATE on attendance: Tự tính total_hours khi nhân viên checkout
