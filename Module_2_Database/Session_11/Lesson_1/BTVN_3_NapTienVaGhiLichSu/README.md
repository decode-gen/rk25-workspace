# BTVN 3: Giao dịch Nạp tiền và Ghi lịch sử (Session 11)

## 1. Mục tiêu
- Thiết kế bảng lưu trữ lịch sử giao dịch (transactions)
- Thực hiện kỹ thuật All-or-Nothing qua DECLARE EXIT HANDLER FOR SQLEXCEPTION

## 2. Mô tả & Yêu cầu
- Bảng accounts và bảng transactions (transaction_id, account_id, amount, log_message, transaction_date)
- Viết Stored Procedure deposit_with_logging(IN p_account_id, IN p_amount)
- Thực hiện cộng tiền và chèn log lịch sử trong cùng một Transaction
- Kiểm thử nạp 1.000.000 VNĐ vào tài khoản ID = 3
