# BTVN 4: Stored Procedure có câu lệnh điều kiện IF (Session 08)

## 1. Mục tiêu
- Nắm vững cú pháp rẽ nhánh IF - ELSE trong Stored Procedure
- Xử lý logic phân luồng trực tiếp ngay trong cơ sở dữ liệu

## 2. Mô tả & Yêu cầu
- Bảng orders: order_id, total_amount
- Tạo Stored Procedure sp_check_order_value nhận vào tổng tiền (p_total)
- Nếu p_total >= 5.000.000 -> Thông báo "Đơn hàng giá trị cao"
- Ngược lại -> Thông báo "Đơn hàng bình thường"
