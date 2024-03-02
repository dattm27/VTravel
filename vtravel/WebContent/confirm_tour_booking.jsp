<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- để định dạng số tiền -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta charset="UTF-8">
<title>Xác nhận đặt chuyến phổ thông</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<!-- Thêm script của Bootstrap Modal -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.2/js/bootstrap.bundle.min.js"></script>
	<script>
        function updateTotalBill() {
            // Lấy giá vé từ server-side (có thể sử dụng JSTL để nhúng giá trị từ Java vào JavaScript)
            var ticketPrice = ${tour.price};

            // Lấy số lượng người từ ô nhập liệu
            var numberOfTourists = document.getElementById("number_of_tourists").value;

            // Tính tổng tiền
            var totalBill = ticketPrice * numberOfTourists;

            // Hiển thị tổng tiền trong ô nhập liệu
            document.getElementById("total_bill").value = totalBill;
            
            
        }
    </script>
</head>
<body>
	<!-- Phần nav-bar -->
	<jsp:include page="navbar.jsp" />
	<!-- Hết phần navbar -->

	<!-- Phần thân trang -->
	<div class="container">
		<div class="row mt-3">
			<!-- Phần bên trái với form nhập thông tin -->
			<div class="col-md-7">
				
				<form action="TourControllerServlet" method ="POST"  onsubmit="return confirmSubmit()">
						<input type="hidden" name = "command" value = "BOOKING">
						<input type="hidden" name = "userID" value = "${user.ID}">
						<input type="hidden" name = "tourID" value = "${tour.ID}">
						<h3 class="mt-3">Thông tin khách hàng</h3>
						<div class="mb-3">
							<label for="disabledTextInput" class="form-label">Tên khách hàng</label> <input type="text" id="disabledTextInput"
								class="form-control" placeholder="" value="${user.fullname}" readonly>
						</div>
						<div class="form-group">
							<label for="start_date">Số điện thoại:</label> <input type="tel"
								class="form-control" id="phone_number" name="phone_number" readonly value= "${user.phoneNumber}">
						</div>
						<div class="form-group">
							<label for="end_date">Địa điểm đón:</label> 
							<input type="text"
								class="form-control" id="pick_up_location" name="pick_up_location" placeholder="Nhập địa điểm đón" required>
						</div>	
						<h3 class="mt-3">Đặt vé</h3>	
						<div class="mb-3">
							<label for="disabledTextInput" class="form-label">Số
								lượng người</label> 
							<input type="number" id="number_of_tourists" name = "number_of_tourists"
								class="form-control" placeholder="" value ="0" required min = "1" onchange="updateTotalBill()">
						</div>
						<div class="mb-3">
							<label for="disabledTextInput" class="form-label">Tổng tiền</label> 
							<input type="number" id="total_bill"
								class="form-control" placeholder="" value ="0" disabled>
						</div>
						<div class="mb-3 form-check">
						<input type="checkbox" class="form-check-input" id="exampleCheck1" required > 
						<label class="form-check-label" for="exampleCheck1">Tôi đồng ý với các điều khoản và chính sách</label>
					</div>
					<button type="submit" class="btn btn-primary">Xác nhận</button>
					<script>
					    function confirmSubmit() {
					        // Sử dụng hàm confirm để hiển thị hộp thoại xác nhận
					        var confirmResult = confirm("Bạn có chắc chắn các thông tin là chính xác?");
					
					        // Nếu người dùng nhấn "OK", return true để submit form, ngược lại return false
					        return confirmResult;
					    }
					</script>
				</form>
			</div>
			<!-- Phần bên phải hiển thị thông tin cơ bản của tour -->
			<div class="col-md-5 mt-3">
				<h4>${tour.name}</h4>
				<img src="${tour.image}" alt="Hình ảnh minh hoạ" class="img-fluid mt-3"
					style="width: 100%; height: 250px; object-fit: cover;">
				<h4 class="mt-3">Thông tin chuyến:</h4>
				<ul class="list-group ">
				  <li class="list-group-item" aria-current="true">Ngày bắt đầu: ${tour.startDate} </li>
				  <li class="list-group-item">Ngày kết thúc:${tour.endDate}  </li>
				  <li class="list-group-item">Điểm khởi hành: ${tour.startPlace}  </li>
				  <li class="list-group-item">Giá vé: <span class = "text-primary"><fmt:formatNumber type="number" maxFractionDigits="2" value="${tour.price}" />  VNĐ</span></li>
			
				</ul>
			</div>
		</div>
	</div>
</body>
</html>