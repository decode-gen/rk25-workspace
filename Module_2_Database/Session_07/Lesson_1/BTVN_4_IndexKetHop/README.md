# BTVN 4: Index kết hợp (Nhiều cột)

## 1. Mục tiêu
- Hiểu sự khác biệt giữa Index đơn và Composite Index (Index kết hợp)
- Tối ưu hóa truy vấn có nhiều điều kiện lọc đồng thời

## 2. Mô tả & Yêu cầu
- Bảng products: product_id, product_name, category, price
- Nghiệp vụ thường lọc theo loại sản phẩm và theo giá bán
- Tạo INDEX kết hợp idx_products_category_price cho (category, price)
