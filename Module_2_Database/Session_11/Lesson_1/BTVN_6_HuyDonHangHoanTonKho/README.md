# BTVN 6: Hủy Đơn Hàng & Hoàn Tồn Kho (Session 11)

## 1. Mục tiêu
- Hiểu quy trình đảo ngược giao dịch (Reverse Transaction)
- Tự động cập nhật cộng lại số lượng vào kho khi hủy đơn

## 2. Mô tả & Yêu cầu
- Bảng products và orders (status: Completed / Cancelled)
- Viết Stored Procedure cancel_order(IN p_order_id)
- Kiểm tra đơn hàng có tồn tại và chưa bị hủy
- Chuyển trạng thái đơn thành 'Cancelled' và cộng hoàn lại số lượng tồn kho
- Kiểm thử mua hàng và hủy đơn hàng
