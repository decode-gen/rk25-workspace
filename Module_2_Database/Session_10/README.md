# Session 10: Triggers trong MySQL (Audit & Ràng buộc nâng cao)

## 1. Giới thiệu Triggers
- **Định nghĩa:** Trigger là một đối tượng CSDL đặc biệt, tự động kích hoạt khi có sự kiện thay đổi dữ liệu (INSERT, UPDATE, DELETE) trên một bảng cụ thể.
- **Thời điểm kích hoạt:**
  - BEFORE: Kích hoạt trước khi thao tác ghi xuống đĩa, thường dùng để kiểm tra tính hợp lệ (Validation) hoặc chặn ghi dữ liệu bất hợp pháp.
  - AFTER: Kích hoạt sau khi thao tác ghi hoàn tất, thường dùng để ghi vết lịch sử (Audit Log) hoặc đồng bộ dữ liệu sang bảng khác.
- **Biến ngữ cảnh OLD và NEW:**
  - OLD: Chứa giá trị của bản ghi TRƯỚC KHI thay đổi (có trong UPDATE, DELETE).
  - NEW: Chứa giá trị của bản ghi SAU KHI thay đổi (có trong INSERT, UPDATE).
- **Chặn thao tác với SIGNAL SQLSTATE:** Ném ngoại lệ nghiệp vụ (SQLSTATE '45000') để rollback và từ chối hành động vi phạm.

## 2. Danh sách bài tập (BTVN)
1. **BTVN 1:** Ghi lại thay đổi số lượng sản phẩm (AfterProductUpdate vào InventoryChanges)
2. **BTVN 2:** Không cho phép xóa sản phẩm theo điều kiện (BeforeProductDelete chặn khi tồn kho > 10)
3. **BTVN 3:** Tự động kiểm tra số lượng sản phẩm trước khi insert (BeforeInsertProduct chặn số lượng âm)
4. **BTVN 4:** Ghi nhật ký thay đổi mức lương (	rg_after_update_salary lưu old_salary, 
ew_salary)
5. **BTVN 5:** Ghi nhật ký thay đổi trạng thái đơn hàng (fter_order_status_update lưu timeline status)
6. **BTVN 6:** Kiểm tra tồn kho trước khi thêm vào giỏ hàng (efore_cart_add chặn vượt stock)
