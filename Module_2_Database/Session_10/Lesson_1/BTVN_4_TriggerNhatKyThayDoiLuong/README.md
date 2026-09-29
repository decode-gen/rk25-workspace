# BTVN 4: Ghi nhật ký thay đổi mức lương nhân viên (Session 10)

## 1. Mục tiêu
- Theo dõi lịch sử biến động dữ liệu nhạy cảm (mức lương)
- Lưu vết old_salary và new_salary cùng thời điểm điều chỉnh

## 2. Mô tả & Yêu cầu
- Bảng employees và salary_log (thêm 10 bản ghi nhân viên)
- Tạo Trigger trg_after_update_salary kích hoạt SAU KHI UPDATE
- Nếu lương thay đổi (OLD.salary <> NEW.salary) thì chèn vào salary_log
- Kiểm thử cập nhật lương và cập nhật các cột khác không đổi lương
