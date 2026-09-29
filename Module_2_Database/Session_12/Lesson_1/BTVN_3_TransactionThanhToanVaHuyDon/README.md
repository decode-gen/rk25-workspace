# BTVN 3: Transaction Thanh Toán & Hủy Đơn Hàng (Session 12)

## 1. Mục tiêu
- Xử lý 2 tình huống then chốt: Thanh toán đơn và Hủy đơn hàng
- Đảm bảo Atomicity khi ghi bảng payments và hoàn trả kho

## 2. Mô tả & Yêu cầu
- Stored Procedure sp_pay_order(order_id, payment_method): Kiểm tra trạng thái Pending, chèn payments, đổi status thành Completed, COMMIT
- Stored Procedure sp_cancel_order(order_id): Kiểm tra trạng thái Pending, cộng hoàn lại inventory, xóa order_items, đổi status thành Cancelled, COMMIT
