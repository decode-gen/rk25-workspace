# Session 12: Tổng hợp Trigger & Transaction trong Hệ Thống Doanh Nghiệp

## 1. Mục tiêu tích hợp
- Kết hợp toàn diện sức mạnh của **Trigger** (kiểm soát tự động tính toàn vẹn) và **Transaction** (đảm bảo tính toàn vẹn đa bước) trong các kịch bản thực tế:
  - **Hệ thống Thương mại điện tử (Ecommerce):** Quản lý giỏ hàng, đặt hàng, trừ tồn kho, tính tổng tiền, thanh toán và hủy đơn hoàn kho.
  - **Hệ thống Quản trị nhân sự (HRM):** Chuẩn hóa email, tự động cấp lương cơ bản, tính công chấm công checkout, điều chỉnh thăng chức tăng lương và cho thôi việc có bảo toàn lịch sử kiểm toán.

## 2. Danh sách bài tập (BTVN)
1. **BTVN 1:** Luyện tập các loại Trigger với CSDL Ecommerce (Trọn bộ 6 Trigger: BEFORE/AFTER cho INSERT/UPDATE/DELETE)
2. **BTVN 2:** Transaction Tạo Đơn Hàng Ecommerce (`sp_create_order` trừ tồn kho và tạo chi tiết đơn hàng)
3. **BTVN 3:** Transaction Thanh Toán & Hủy Đơn Hàng Ecommerce (`sp_pay_order` và `sp_cancel_order`)
4. **BTVN 4:** Luyện tập Trigger trong quản trị nhân sự (Chuẩn hóa email, tự sinh lương, tự tính giờ làm)
5. **BTVN 5:** Ứng dụng Transaction trong quản trị nhân viên (`IncreaseSalary` & `DeleteEmployee`)
