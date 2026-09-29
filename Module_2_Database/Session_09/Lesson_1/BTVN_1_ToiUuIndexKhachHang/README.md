# BTVN 1: Tối ưu hóa tốc độ tìm kiếm khách hàng với Index (Session 09)

## 1. Mục tiêu
- Hiểu sự khác biệt giữa UNIQUE INDEX và Non-Unique INDEX
- Tối ưu hóa truy vấn tìm kiếm nhanh theo email và số điện thoại

## 2. Mô tả & Yêu cầu
- Bảng customers: customer_id, customer_name, email, phone, address
- Tạo UNIQUE INDEX idx_customers_email trên cột email
- Tạo INDEX idx_customers_phone trên cột phone
- Sử dụng EXPLAIN để kiểm tra kế hoạch thực thi
