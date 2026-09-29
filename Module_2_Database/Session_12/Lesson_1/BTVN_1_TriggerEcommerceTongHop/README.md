# BTVN 1: Luyện tập các loại Trigger với CSDL Ecommerce (Session 12)

## 1. Mục tiêu
- Làm quen và làm chủ trọn bộ 6 loại Trigger trong MySQL
- Kiểm soát kho, tự động tính tổng tiền và chặn xóa đơn hàng đã thanh toán

## 2. Mô tả & Yêu cầu
- CSDL gồm các bảng: customers, products, inventory, orders, order_items
- Triển khai 6 Trigger:
  - BEFORE INSERT on order_items: Kiểm tra tồn kho
  - AFTER INSERT on order_items: Cộng total_amount trong orders
  - BEFORE UPDATE on order_items: Kiểm tra tồn kho khi tăng số lượng
  - AFTER UPDATE on order_items: Cập nhật lại total_amount
  - BEFORE DELETE on orders: Chặn xóa đơn Completed bằng SIGNAL SQLSTATE
  - AFTER DELETE on order_items: Hoàn trả số lượng vào inventory
