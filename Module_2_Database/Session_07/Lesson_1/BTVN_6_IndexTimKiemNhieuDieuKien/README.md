# BTVN 6: Index phục vụ tìm kiếm theo nhiều điều kiện

## 1. Mục tiêu
- Tư duy chọn lọc cột tối ưu để tạo Index nhiều điều kiện
- Tăng tốc tra cứu trạng thái đơn hàng theo mốc thời gian

## 2. Mô tả & Yêu cầu
- Bảng orders: order_id, order_date, order_status, total_amount
- Nghiệp vụ thường xuyên lọc theo order_status và order_date
- Tạo INDEX idx_orders_status_date cho (order_status, order_date)
