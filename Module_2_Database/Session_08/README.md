# Session 08: Stored Procedures trong MySQL

## 1. Giới thiệu Stored Procedure
- **Định nghĩa:** Stored Procedure (Thủ tục lưu trữ) là tập hợp các câu lệnh SQL được biên dịch và lưu trữ trực tiếp trên Database Server, hoạt động tương tự như hàm (function) trong ngôn ngữ lập trình.
- **Ưu điểm:**
  - Tăng hiệu suất thực thi: Database biên dịch sẵn Execution Plan, giảm tải phân tích cú pháp mỗi lần chạy.
  - Tiết kiệm băng thông: Ứng dụng chỉ cần gửi lệnh CALL procedure_name(args) thay vì gửi cả đoạn script dài.
  - Bảo mật dữ liệu: Hạn chế SQL Injection, kiểm soát quyền gọi thủ tục mà không cần cấp quyền trực tiếp trên bảng vật lý.
  - Module hóa: Dễ bảo trì và tái sử dụng logic nghiệp vụ trên CSDL.
- **Phân loại tham số:**
  - IN: Tham số đầu vào (mặc định), truyền giá trị vào bên trong thủ tục.
  - OUT: Tham số đầu ra, thủ tục gán kết quả và trả ngược ra biến bên ngoài.
  - INOUT: Kết hợp cả đầu vào và đầu ra.

## 2. Danh sách bài tập (BTVN)
1. **BTVN 1:** Stored Procedure không có tham số (sp_get_all_students)
2. **BTVN 2:** Stored Procedure có tham số IN (sp_get_products_by_category)
3. **BTVN 3:** Sử dụng biến trong Stored Procedure (sp_get_avg_salary với DECLARE và INTO)
4. **BTVN 4:** Stored Procedure có câu lệnh điều kiện IF (sp_check_order_value)
5. **BTVN 5:** Stored Procedure sử dụng nhiều tham số và IF (sp_check_employee_income)
6. **BTVN 6:** Stored Procedure sử dụng biến + CASE + Tham số OUT (sp_classify_student)
