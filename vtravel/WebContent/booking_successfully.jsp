<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Đặt tour thành công</title>
	<!-- CSS Bootstrap -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body  class="bg-light">
	<div class="container mt-2">
        <div class="card mx-auto" style="max-width: 450px;">
            <div class="card-body text-center">
                <h1 class="display-1 text-success ">&#10003;</h1>
                <h4 class="card-title mt-3">Đặt Tour Thành Công!</h4>
                <p class="card-text">Cảm ơn bạn đã đặt tour.</p>
                <p class = "text-primary"> Chúng tôi sẽ liên hệ với bạn trong thời gian sớm nhất.</p>
                <div class="mt-4">
                    <c:url var = "Home" value = "WelcomeControllerServlet">
                    </c:url>
                    <a href="${Home}" class="btn btn-primary">Về Trang Chủ</a>
                    <c:url var = "LIST_MY_TOUR" value = "TourControllerServlet">
                    	<c:param name = "command" value = "LIST_MY_TOUR"/>
                    	<c:param name = "ID" value = "${ID}"/>
                    </c:url>
                    <a href="${LIST_MY_TOUR}" class="btn btn-success">Xem Danh Sách Đặt Tour</a>
                </div>
            </div>
        </div>
        <h3 class="mt-3">Kênh thanh toán:</h3>
        <div class="row row-cols-1 row-cols-lg-4 g-4 mb-3">
		  <div class="col">
		    <div class="card h-60">
		      <img src="images/QRBIDV.JPG" class="card-img-top" alt="..." style="height: 250px">
		      <div class="card-body">
		        <h5 class="card-title">BIDV</h5>
		        <div >STK: 4430394543</div>
		        <div >CTK: TRAN MANH DAT</div>
		      </div>
		    </div>
		  </div>
		  <div class="col">
		    <div class="card h-60">
		      <img src="images/QRMB.jpeg" class="card-img-top" alt="..." style="height: 250px">
		      <div class="card-body">
		        <h5 class="card-title">MB</h5>
		        <div>STK: 0827666910</div>
		        <div >CTK: TRAN MANH DAT</div>
		      </div>
		    </div>
		  </div>
		  <div class="col">
		    <div class="card h-60">
		      <img src="images/QRTECHCOMBANK.jpg" class="card-img-top" alt="..." style="height: 250px">
		      <div class="card-body">
		        <h5 class="card-title">TECHCOMBANK</h5>
		        <div>STK: 1903 9944 7520 18</div>
		        <div>CTK: PHAN VIET HOANG</div>
		      </div>
		    </div>
		  </div>
		  <div class="col">
		    <div class="card h-60">
		      <img src="images/QRVIETINBANK.jpg" class="card-img-top" alt="..." style="height: 250px">
		      <div class="card-body">
		        <h5 class="card-title">VIETINBANK</h5>
		        <div class="card-text">STK: 102873396890</div>
		        <div>CTK: TRAN DANH LINH</div>
		      </div>
		    </div>
		  </div>
		</div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	
</body>
</html>