# BTVN 5: Báo cáo doanh thu khách hàng với View phức tạp (Session 09)

## 1. Mục tiêu
- Kết hợp View với các lệnh JOIN (LEFT JOIN) và hàm tổng hợp SUM, COUNT
- Tạo báo cáo doanh số đa chiều hỗ trợ ban quản trị

## 2. Mô tả & Yêu cầu
- Bảng orders kết hợp bảng customers và products (20 bản ghi đơn hàng)
- Tạo VIEW view_customer_spending gồm: customer_id, customer_name, total_orders, total_spent
- GROUP BY theo khách hàng và xử lý trường hợp chưa phát sinh đơn
