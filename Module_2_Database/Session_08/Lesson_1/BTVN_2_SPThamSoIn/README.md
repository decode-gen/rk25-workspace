# BTVN 2: Stored Procedure có tham số IN (Session 08)

## 1. Mục tiêu
- Hiểu vai trò của tham số đầu vào (IN parameter)
- Biết truyền giá trị vào Stored Procedure và sử dụng trong WHERE

## 2. Mô tả & Yêu cầu
- Bảng products: product_id, product_name, price, category
- Tạo Stored Procedure sp_get_products_by_category nhận vào loại sản phẩm (p_category)
- Truy vấn tất cả sản phẩm thuộc loại được truyền vào
- Gọi thử nghiệm với các loại sản phẩm khác nhau
