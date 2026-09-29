# BTVN 1: Ghi lại thay đổi số lượng sản phẩm với Trigger (Session 10)

## 1. Mục tiêu
- Hiểu và thực hành cú pháp Trigger AFTER UPDATE
- Sử dụng OLD và NEW để phát hiện thay đổi và ghi Audit Log

## 2. Mô tả & Yêu cầu
- Bảng Products và InventoryChanges
- Tạo Trigger AfterProductUpdate trên bảng Products
- Tự động chèn bản ghi vào InventoryChanges khi OLD.quantity <> NEW.quantity
- Kiểm thử cập nhật số lượng và kiểm tra bảng lịch sử
