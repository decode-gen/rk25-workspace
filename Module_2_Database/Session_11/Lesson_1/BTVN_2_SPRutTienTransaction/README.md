# BTVN 2: Tạo Stored Procedure Rút Tiền (Session 11)

## 1. Mục tiêu
- Nhúng Transaction vào trong Stored Procedure
- Vận dụng kỹ thuật kiểm tra số dư và ROLLBACK khi tài khoản âm

## 2. Mô tả & Yêu cầu
- Sử dụng bảng accounts (tài khoản ID = 2 có số dư 300.000đ)
- Viết Stored Procedure withdraw_money(IN p_account_id, IN p_amount)
- Bắt đầu Transaction -> UPDATE trừ tiền -> Kiểm tra balance
- Nếu balance < 0: ROLLBACK và thông báo "Số dư không đủ"
- Nếu balance >= 0: COMMIT và thông báo "Rút tiền thành công"
- Kiểm thử rút 500k (thất bại) và rút 100k (thành công)
