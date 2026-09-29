# BTVN 2: Transaction Tạo Đơn Hàng Ecommerce (Session 12)

## 1. Mục tiêu
- Rèn luyện kỹ năng tạo TRANSACTION kết hợp Stored Procedure
- Đảm bảo tính toàn vẹn khi tạo đơn hàng mới và cập nhật trừ kho

## 2. Mô tả & Yêu cầu
- Viết Stored Procedure sp_create_order(customer_id, product_id, quantity, price)
- Bắt đầu Transaction -> Kiểm tra stock tồn kho
- Nếu đủ hàng: INSERT vào orders, lấy LAST_INSERT_ID(), INSERT vào order_items, UPDATE trừ inventory, COMMIT
- Nếu không đủ: ROLLBACK và thông báo lỗi
