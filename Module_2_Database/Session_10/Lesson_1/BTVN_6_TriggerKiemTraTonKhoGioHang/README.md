# BTVN 6: Kiểm tra tồn kho trước khi thêm vào giỏ hàng (Session 10)

## 1. Mục tiêu
- Áp dụng Trigger BEFORE INSERT liên bảng giữa cart_items và Products
- Chặn hành vi đặt mua vượt quá số lượng hàng tồn kho thực tế

## 2. Mô tả & Yêu cầu
- Bảng cart_items tham chiếu tới Products
- Tạo Trigger before_cart_add
- Lấy tồn kho của sản phẩm được thêm (NEW.product_id)
- Nếu NEW.quantity > quantity trong kho: Chặn và ném thông báo lỗi
- Kiểm thử thêm số lượng hợp lệ và thêm vượt tồn kho
