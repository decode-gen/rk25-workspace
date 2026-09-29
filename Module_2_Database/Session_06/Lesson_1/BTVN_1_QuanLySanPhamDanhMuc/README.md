# BTVN 1: Quản lý sản phẩm & danh mục

## 1. Mục tiêu
- Thực hành các thao tác cơ bản với SQL: INSERT, UPDATE, DELETE, SELECT
- Hiển thị dữ liệu có sắp xếp ORDER BY
- Sử dụng GROUP BY để thống kê số lượng sản phẩm trong từng danh mục

## 2. Yêu cầu & CSDL
- Bảng categories: category_id (PK), category_name
- Bảng products: product_id (PK), product_name, price, category_id (FK)
- Thêm 3 sản phẩm mới, cập nhật giá, xóa 1 sản phẩm
- Hiển thị tất cả sản phẩm sắp xếp giảm dần theo giá
- Thống kê số lượng sản phẩm cho từng danh mục
