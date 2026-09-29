# BTVN 5: Ghi nhật ký thay đổi trạng thái đơn hàng (Session 10)

## 1. Mục tiêu
- Xây dựng Order History Timeline cho các ứng dụng E-commerce
- So sánh OLD.status <> NEW.status để lưu vết lộ trình vận chuyển

## 2. Mô tả & Yêu cầu
- Bảng orders và order_logs
- Tạo Trigger after_order_status_update trên bảng orders
- Lưu lịch sử trạng thái cũ và mới kèm mốc thời gian
- Kiểm thử chuyển trạng thái Pending -> Shipping -> Completed
