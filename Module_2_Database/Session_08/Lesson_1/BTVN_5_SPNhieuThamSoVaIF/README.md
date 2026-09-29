# BTVN 5: Stored Procedure sử dụng nhiều tham số và IF (Session 08)

## 1. Mục tiêu
- Sử dụng nhiều tham số đầu vào IN kết hợp biến cục bộ
- Áp dụng cấu trúc rẽ nhánh đa tầng IF - ELSEIF - ELSE

## 2. Mô tả & Yêu cầu
- Bảng employees: employee_id, full_name, salary, department
- Tạo Stored Procedure sp_check_employee_income(IN p_name, IN p_salary)
- Phân bậc: >= 15tr (Thu nhập cao), 8-15tr (Thu nhập trung bình), < 8tr (Thu nhập thấp)
- Trả về bảng kết quả gồm tên nhân viên và mức thu nhập
