# Session 07: Tối ưu hóa CSDL với VIEW và INDEX

## 1. Giới thiệu View & Index
- **VIEW (Bảng ảo):** Lưu câu lệnh SELECT phức tạp trên server. Tăng bảo mật (ẩn các cột nhạy cảm như lương, CCCD), đơn giản hóa truy vấn nhiều bảng và hỗ trợ tương thích ngược.
- **INDEX (Chỉ mục):** Cấu trúc B-Tree tăng tốc độ tìm kiếm dữ liệu trên cột có tần suất WHERE/JOIN cao. Giảm thời gian quét tuần tự (Full Table Scan).

## 2. Danh sách bài tập (BTVN)
1. **BTVN 1:** Làm quen với View (Một bảng - v_student_basic)
2. **BTVN 2:** View từ nhiều bảng (v_order_info kết hợp customers + orders)
3. **BTVN 3:** Làm quen với Index (Một cột - idx_employees_department)
4. **BTVN 4:** Index kết hợp (Nhiều cột - idx_products_category_price)
5. **BTVN 5:** View phục vụ phân quyền truy cập (v_employee_public ẩn lương, CMND)
6. **BTVN 6:** Index phục vụ tìm kiếm theo nhiều điều kiện (idx_orders_status_date)
