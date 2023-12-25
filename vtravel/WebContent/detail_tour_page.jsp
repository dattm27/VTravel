<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- để định dạng số tiền -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>VTravel</title>
	<!-- Bootstrap CSS -->
	  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<!-- include navbar vào -->
	 <jsp:include page="navbar.jsp" />
	<div class = "container">
		<h2 class= "mt-3 mb-2">${tour.name}</h2>
		<div class = "row">
			<div class="col-9">
				<img src="${tour.image}" style="max-width: 100%" alt="Ảnh mình hoạ ${tour.name}">
				<h3 class="mt-3">Lịch trình</h3>
				
					
				
			</div>
			
			<div class="col-3">
				<h3>Thông tin chuyến đi</h3>
				<h6>Ngày bắt đầu: ${tour.startDate} </h6>
				<hr>
				<h6>Ngày kết thúc: ${tour.endDate}</h6>
				<hr>
				<h6>Điểm khởi hành: ${tour.startPlace} </h6>
				<hr>
				<h5>Giá: <span class="text-primary-emphasis"><fmt:formatNumber type="number" maxFractionDigits="2" value="${tour.price}" /> </span> VNĐ</h5>
				<br>
				<h3>Đặt vé</h3>
				<button class="btn btn-primary mt-3" type="button" style="width:100%">Đặt tour ngay</button>
			
			</div>
		</div>
		<div class = "row">
			${tour.description}
		</div>
	</div>
</body>
</html>