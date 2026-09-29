# BTVN 5: View phục vụ phân quyền truy cập

## 1. Mục tiêu
- Sử dụng VIEW làm lá chắn bảo mật dữ liệu nhạy cảm
- Phân quyền cho nhân sự các phòng ban khác xem dữ liệu công khai

## 2. Mô tả & Yêu cầu
- Bảng employees: employee_id, full_name, department, salary, identity_card
- Nhân sự thông thường không được xem salary và identity_card
- Tạo VIEW _employee_public chỉ hiển thị employee_id, full_name, department
