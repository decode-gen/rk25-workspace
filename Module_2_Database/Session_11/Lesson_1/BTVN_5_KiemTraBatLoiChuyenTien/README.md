# BTVN 5: Kiểm Tra & Bắt Lỗi Chuyển Tiền Nâng Cao (Session 11)

## 1. Mục tiêu
- Kiểm tra toàn vẹn tài khoản nhận và số tiền giao dịch
- Bắt lỗi ngoại lệ và phản hồi thông điệp chính xác

## 2. Mô tả & Yêu cầu
- Viết Stored Procedure transfer_money_advanced
- Kiểm tra số tiền chuyển phải > 0
- Kiểm tra sự tồn tại của tài khoản nhận
- Kiểm tra số dư người gửi trước khi thực hiện
- Hủy bỏ giao dịch bằng ROLLBACK nếu có vi phạm
