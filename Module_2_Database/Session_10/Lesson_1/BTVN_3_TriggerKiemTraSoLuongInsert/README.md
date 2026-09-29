# BTVN 3: Kiểm tra số lượng sản phẩm trước khi insert (Session 10)

## 1. Mục tiêu
- Thực hành Trigger BEFORE INSERT kiểm tra tính hợp lệ dữ liệu
- Ngăn chặn nhập liệu số âm phá hủy logic kho hàng

## 2. Mô tả & Yêu cầu
- Bảng Products
- Tạo Trigger BeforeInsertProduct kiểm tra NEW.quantity
- Nếu NEW.quantity < 0: Báo lỗi và hủy câu lệnh INSERT
- Kiểm thử thêm sản phẩm hợp lệ và sản phẩm có số lượng âm
