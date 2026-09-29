# BTVN 2: Không cho phép xóa sản phẩm theo điều kiện (Session 10)

## 1. Mục tiêu
- Sử dụng Trigger BEFORE DELETE để bảo vệ tính toàn vẹn dữ liệu
- Chặn hành động và ném lỗi nghiệp vụ bằng SIGNAL SQLSTATE / RAISE

## 2. Mô tả & Yêu cầu
- Bảng Products
- Tạo Trigger BeforeProductDelete kiểm tra số lượng tồn kho trước khi xóa
- Nếu OLD.quantity > 10: Chặn xóa và thông báo lỗi
- Kiểm thử xóa sản phẩm tồn ít (thành công) và sản phẩm tồn nhiều (bị chặn)
