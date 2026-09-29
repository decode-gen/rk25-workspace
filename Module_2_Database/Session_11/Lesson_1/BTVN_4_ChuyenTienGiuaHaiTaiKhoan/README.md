# BTVN 4: Chuyển Tiền Giữa Hai Tài Khoản (Session 11)

## 1. Mục tiêu
- Đóng gói Transaction chuyển khoản liên tài khoản
- Đảm bảo tính nhất quán (Consistency) bảo toàn tổng số dư

## 2. Mô tả & Yêu cầu
- Bảng accounts: Tài khoản A (ID = 4) có 2.000.000đ, Tài khoản B (ID = 5) có 0đ
- Viết Stored Procedure transfer_money(IN p_sender_id, IN p_receiver_id, IN p_amount)
- Trừ tiền người gửi và cộng tiền người nhận
- Tự động ROLLBACK nếu số dư người gửi không đủ
- Kiểm thử chuyển 300.000 VNĐ từ ID 4 sang ID 5
