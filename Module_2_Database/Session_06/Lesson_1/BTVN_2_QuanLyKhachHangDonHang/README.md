# BTVN 2: Quản lý Khách hàng & Đơn hàng

## 1. Mục tiêu
- Thực hành quản lý dữ liệu khách hàng và đơn hàng
- Sử dụng INNER JOIN, LEFT JOIN, GROUP BY, Subquery
- Phân tích tổng doanh thu theo khách hàng

## 2. Yêu cầu & CSDL
- Bảng customers: customer_id (PK), customer_name, email
- Bảng orders: order_id (PK), order_date, customer_id (FK)
- Bảng order_details: order_detail_id (PK), order_id (FK), product_name, quantity, price
- Liệt kê khách hàng có đơn hàng và khách hàng chưa từng đặt hàng
- Tính tổng chi tiêu của mỗi khách hàng và tìm khách hàng mua món đắt nhất
