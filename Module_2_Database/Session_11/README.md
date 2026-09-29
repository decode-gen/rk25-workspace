# Session 11: Transaction & Hệ Tiêu Chuẩn ACID trong CSDL

## 1. Giới thiệu Transaction (Giao dịch)
- **Định nghĩa:** Transaction (Giao dịch) là một chuỗi gồm nhiều thao tác SQL (thường là UPDATE, INSERT, DELETE) được thực hiện như một đơn vị công việc logic duy nhất.
- **Tiêu chuẩn ACID cốt lõi:**
  - **A (Atomicity - Tính nguyên tử):** "Tất cả hoặc không gì cả" (All-or-Nothing). Hoặc mọi câu lệnh trong transaction đều hoàn thành (COMMIT), hoặc không có câu lệnh nào được lưu (ROLLBACK).
  - **C (Consistency - Tính nhất quán):** Dữ liệu phải chuyển từ trạng thái hợp lệ này sang trạng thái hợp lệ khác, không vi phạm bất kỳ ràng buộc dữ liệu nào (ví dụ tổng tiền 2 tài khoản không đổi).
  - **I (Isolation - Tính độc lập):** Các transaction thực thi đồng thời không được can thiệp lẫn nhau.
  - **D (Durability - Tính bền vững):** Một khi transaction đã COMMIT, dữ liệu sẽ được lưu vĩnh viễn trên đĩa cứng ngay cả khi mất điện hoặc sập server.
- **Các câu lệnh quản lý:**
  - `START TRANSACTION` / `BEGIN`: Mở phiên giao dịch.
  - `COMMIT`: Lưu vĩnh viễn tất cả các thay đổi.
  - `ROLLBACK`: Hủy bỏ tất cả các thay đổi từ thời điểm bắt đầu giao dịch.
  - `DECLARE EXIT HANDLER FOR SQLEXCEPTION`: Tự động bắt lỗi và Rollback trong Stored Procedure.

## 2. Danh sách bài tập (BTVN)
1. **BTVN 1:** Gửi tiền vào tài khoản (`START TRANSACTION` & `COMMIT`)
2. **BTVN 2:** Tạo Stored Procedure Rút Tiền (`withdraw_money` với cơ chế Rollback khi số dư âm)
3. **BTVN 3:** Giao dịch Nạp tiền và Ghi lịch sử (`deposit_with_logging` bảo đảm All-or-Nothing)
4. **BTVN 4:** Chuyển Tiền Giữa Hai Tài Khoản (`transfer_money` bảo toàn số dư)
5. **BTVN 5:** Kiểm Tra & Bắt Lỗi Chuyển Tiền Nâng Cao (Bắt lỗi số dư, kiểm tra tài khoản nhận)
6. **BTVN 6:** Hủy Đơn Hàng & Hoàn Tồn Kho (`cancel_order` - Reverse Transaction)
