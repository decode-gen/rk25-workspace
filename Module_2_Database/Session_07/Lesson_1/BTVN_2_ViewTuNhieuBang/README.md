# BTVN 2: View từ nhiều bảng

## 1. Mục tiêu
- Tạo VIEW kết hợp dữ liệu từ nhiều bảng qua JOIN
- Đơn giản hóa các truy vấn đơn hàng lặp đi lặp lại của nhân viên bán hàng

## 2. Mô tả & Yêu cầu
- Bảng customers: customer_id, customer_name
- Bảng orders: order_id, order_date, customer_id
- Tạo VIEW _order_info hiển thị order_id, order_date, customer_name
