# BTVN 6: Thủ tục thêm đơn hàng có kiểm tra tồn kho (Session 09)

## 1. Mục tiêu
- Sử dụng tham số OUT để trả lý do thành công hoặc từ chối đơn hàng
- Xử lý nghiệp vụ kiểm tra kho trước khi trừ tồn kho và tạo đơn

## 2. Mô tả & Yêu cầu
- Viết thủ tục add_order(IN _customer_id, IN _product_id, IN _quantity, OUT _message)
- Nếu kho không đủ: gán thông báo "Không đủ số lượng sản phẩm để đặt hàng."
- Nếu đủ hàng: trừ stock trong products, INSERT vào orders, gán thông báo "Thêm đơn hàng thành công!"
