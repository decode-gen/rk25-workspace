# Session 09: Tối ưu hóa CSDL & Thủ tục nâng cao

## 1. Nội dung trọng tâm
- **Chỉ mục (Index) chuyên sâu:** Tạo UNIQUE INDEX trên email và Non-Unique Index trên số điện thoại, phân tích kế hoạch truy vấn với EXPLAIN.
- **View báo cáo tổng hợp:** Kết hợp INNER JOIN / LEFT JOIN với các hàm tổng hợp COUNT(), SUM(), GROUP BY để xuất báo cáo khách hàng và doanh thu mà không để lộ chi tiết bảng gốc.
- **Thủ tục xử lý giao dịch & kho:** Viết Stored Procedure kiểm tra số lượng tồn kho trước khi tạo đơn hàng (dd_order), quản lý tham số OUT để trả mã phản hồi nghiệp vụ.

## 2. Danh sách bài tập (BTVN)
1. **BTVN 1:** Tối ưu hóa tốc độ tìm kiếm khách hàng với Index (idx_customers_email, idx_customers_phone)
2. **BTVN 2:** Tạo danh sách liên lạc rút gọn với View (iew_customer_contact)
3. **BTVN 3:** Thủ tục lấy danh sách sản phẩm giá cao (get_high_value_products)
4. **BTVN 4:** Thủ tục thêm mới khách hàng với tham số IN (insert_customer)
5. **BTVN 5:** Báo cáo doanh thu theo khách hàng với View phức tạp (iew_customer_spending)
6. **BTVN 6:** Thủ tục thêm mới đơn hàng có kiểm tra tồn kho & tham số OUT (dd_order)
