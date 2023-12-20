<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- để định dạng số tiền -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>V Travel - Trang chủ</title>
    <!-- Thư viện CSS Bootstrap -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Thêm script của Bootstrap Modal -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.2/js/bootstrap.bundle.min.js"></script>
   <!-- link file css cho hero ssection -->
   <link rel="stylesheet" href="css/index.css">
</head>
<body>
    <!-- navbar -->
    <jsp:include page="navbar.jsp" />

    <div class="hero-section">
        <div class="brand-info">
            <h1>VietTravel</h1>
            <p>Slogan của bạn ở đây</p>
        </div>
        <div class="search-bar">
            <input type="text" class="search-input" placeholder="Tìm kiếm tour du lịch của bạn">
            <button class="search-button">Tìm kiếm</button>
        </div>
    </div>
	<!-- dịch vụ tour phổ thông -->
    <div class="container" style= "margin-top: 50px">
       
       	<!-- chứa các tour -->
       	<div class="d-flex mb-3 align-items-center">
       	 	<h3 class="">Các tour nổi bật </h3> 
       		 <a class="ml-auto">Xem tất cả </a>
       	</div>
       	<div class = "d-flex justify-content-around flex-wrap">	 
       	   
	        <div class="card mb-3" style="width: 16rem;">
			  <img class="card-img-top" src="images/tour/Halong-bay.jpeg" alt="Card image cap">
			  <div class="card-body">
			    <h5 class="card-title">Du lịch Hạ Long</h5>
			    <div class="card-text text-info" style="font-size:20px">1.800.000đ</div>
			    <div class="card-text">2023-12-20 đến 2023-12-22</div>
			    <div class = "card-text">Đã đặt: 20</div>
			    <a href="#" class="btn btn-primary mt-3">Đặt vé ngay</a>
			  </div>
			</div>
			<div class="card mb-3" style="width: 16rem;">
			  <img class="card-img-top" src="images/tour/Halong-bay.jpeg" alt="Card image cap">
			  <div class="card-body">
			    <h5 class="card-title">Du lịch Hạ Long</h5>
			    <div class="card-text text-info" style="font-size:20px">1.800.000đ</div>
			    <div class="card-text">2023-12-20 đến 2023-12-22</div>
			    <div class = "card-text">Đã đặt: 20</div>
			    <a href="#" class="btn btn-primary mt-3">Đặt vé ngay</a>
			  </div>
			</div>
			<div class="card mb-3" style="width: 16rem;">
			  <img class="card-img-top" src="images/tour/Halong-bay.jpeg" alt="Card image cap">
			  <div class="card-body">
			    <h5 class="card-title">Du lịch Hạ Long</h5>
			    <div class="card-text text-info" style="font-size:20px">1.800.000đ</div>
			    <div class="card-text">2023-12-20 đến 2023-12-22</div>
			    <div class = "card-text">Đã đặt: 20</div>
			    <a href="#" class="btn btn-primary mt-3">Đặt vé ngay</a>
			  </div>
			</div>
			<div class="card mb-3" style="width: 16rem;">
			  <img class="card-img-top" src="images/tour/Halong-bay.jpeg" alt="Card image cap">
			  <div class="card-body">
			    <h5 class="card-title">Du lịch Hạ Long</h5>
			    <div class="card-text text-info" style="font-size:20px">1.800.000đ</div>
			    <div class="card-text">2023-12-20 đến 2023-12-22</div>
			    <div class = "card-text">Đã đặt: 20</div>
			    <a href="#" class="btn btn-primary mt-3">Đặt vé ngay</a>
			  </div>
			</div>
			<div class="card mb-3" style="width: 16rem;">
			  <img class="card-img-top" src="images/tour/Halong-bay.jpeg" alt="Card image cap">
			  <div class="card-body">
			    <h5 class="card-title">Du lịch Hạ Long</h5>
			    <div class="card-text text-info" style="font-size:20px">1.800.000đ</div>
			    <div class="card-text">2023-12-20 đến 2023-12-22</div>
			    <div class = "card-text">Đã đặt: 20</div>
			    <a href="#" class="btn btn-primary mt-3">Đặt vé ngay</a>
			  </div>
			</div>
			<div class="card mb-3" style="width: 16rem;">
			  <img class="card-img-top" src="images/tour/Halong-bay.jpeg" alt="Card image cap">
			  <div class="card-body">
			    <h5 class="card-title">Du lịch Hạ Long</h5>
			    <div class="card-text text-info" style="font-size:20px">1.800.000đ</div>
			    <div class="card-text">2023-12-20 đến 2023-12-22</div>
			    <div class = "card-text">Đã đặt: 20</div>
			    <a href="#" class="btn btn-primary mt-3">Đặt vé ngay</a>
			  </div>
			</div>
			<div class="card mb-3" style="width: 16rem;">
			  <img class="card-img-top" src="images/tour/Halong-bay.jpeg" alt="Card image cap">
			  <div class="card-body">
			    <h5 class="card-title">Du lịch Hạ Long</h5>
			    <div class="card-text text-info" style="font-size:20px">1.800.000đ</div>
			    <div class="card-text">2023-12-20 đến 2023-12-22</div>
			    <div class = "card-text">Đã đặt: 20</div>
			    <a href="#" class="btn btn-primary mt-3">Đặt vé ngay</a>
			  </div>
			</div>
			<div class="card mb-3" style="width: 16rem;">
			  <img class="card-img-top" src="images/tour/Halong-bay.jpeg" alt="Card image cap">
			  <div class="card-body">
			    <h5 class="card-title">Du lịch Hạ Long</h5>
			    <div class="card-text text-info" style="font-size:20px">1.800.000đ</div>
			    <div class="card-text">2023-12-20 đến 2023-12-22</div>
			    <div class = "card-text">Đã đặt: 20</div>
			    <a href="#" class="btn btn-primary mt-3">Đặt vé ngay</a>
			  </div>
			</div>
			
       	</div>
       <!-- Hết các tour -->
       
       <!-- dịch vụ tour phổ thông -->
	    <div class="container" style= "margin-top: 50px">
	       
	       	<!-- chứa các tour -->
	       
			<c:url var="LIST_HOT_TOURS" value="TourControllerServlet">
				<c:param name="command" value="LIST_HOT_TOURS" />
			</c:url>
	       	<div class="d-flex mb-3 align-items-center">
	       	 	<h3 class="">Các tour nổi bật </h3> 
	       		 <a class="ml-auto" href="${LIST_HOT_TOURS}">Xem tất cả </a>
	       	</div>
	       	<div class = "d-flex justify-content-around flex-wrap">	 
	       	   <c:forEach items="${TOUR_LIST}" var="tour">
			        <div class="card mb-3" style="width: 16rem;">
					  <img class="card-img-top" src="images/tour/Halong-bay.jpeg" alt="Card image cap">
					  <div class="card-body">
					    <h5 class="card-title">${tour.name}</h5>
					    <div class="card-text text-info" style="font-size:20px"><fmt:formatNumber type="number" maxFractionDigits="2" value="${tour.price}" /> VNĐ</div>
					    <div class="card-text">Ngày bắt đầu: ${tour.startDate}</div>
					    <div class="card-text">Ngày kết thúc: ${tour.endDate}</div>
					    <div class = "card-text">Đã đặt: 20</div>
					  </div>
					  <div class="card-footer">
					    	<a href="#" class="btn btn-primary">Đặt vé ngay</a>
					    </div>
					</div>
				</c:forEach>
	       	</div>
	       <!-- Hết các tour -->
	       
			 <div class = "d-flex"> 
			 	<a class="ml-auto">Xem tất cả </a>    
			 </div>
			
	        <h3 class="mt-3">Yêu cầu tour tuỳ ý <span class="badge badge-success">NEW</span></h3> 
	        <p> Ngoài cung cấp các tour du lịch có sẵn để các du khách có thể đăng ký chung, VietTravel cũng rất hân hạnh phục vụ các
	        tour theo ý muốn của du khách, nếu bạn có nhu cầu đặt tour du lịch riêng cho lớp học, văn phòng, hay hội nhóm. 
	        Hãy thử ngay dịch vụ mới này của chúng tôi.
	        </p>
			<div class="alert alert-success" role="alert">
				Mời bạn trải nghiệm dịch vụ  <a href="custom_tour.jsp" target="_blank" class="alert-link"> Đặt tour theo ý thích</a>. Nhấn vào link để đăng ký.
			</div>
			<div style = " text-align: center">
				<img src="images/du-lich-nhom.jpg" class="img-fluid" alt="Du lịch nhóm" style="width:60%">
				<div class = "mt-3"> <i>Du lịch theo nhóm cùng dịch vụ tour tuỳ ý của VietTravel</i></div>
			</div>
			
			<h3 class="mt-3">Bài viết nổi bật</h3>
			<div class="media mt-3 mb-3">
			  <img src="images/tour/Halong-bay.jpeg" class="align-self-center mr-3" alt="..." style="width: 200px; height: 200px;  object-fit: cover;">
			  <div class="media-body">
			    <h5 class="mt-0">Center-aligned media</h5>
			    <p>Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis. Fusce condimentum nunc ac nisi vulputate fringilla. Donec lacinia congue felis in faucibus.</p>
			    <p class="mb-0">Donec sed odio dui. Nullam quis risus eget urna mollis ornare vel eu leo. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</p>
			  </div>
			</div>
			<div class="media mt-3 mb-3">
			  <img src="images/tour/Halong-bay.jpeg" class="align-self-center mr-3" alt="..." style="width: 200px; height: 200px;  object-fit: cover;">
			  <div class="media-body">
			    <h5 class="mt-0">Center-aligned media</h5>
			    <p>Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis. Fusce condimentum nunc ac nisi vulputate fringilla. Donec lacinia congue felis in faucibus.</p>
			    <p class="mb-0">Donec sed odio dui. Nullam quis risus eget urna mollis ornare vel eu leo. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</p>
			  </div>
			</div>
			<div class="media mt-3 mb-3">
			  <img src="images/tour/Halong-bay.jpeg" class="align-self-center mr-3" alt="..." style="width: 200px; height: 200px;  object-fit: cover;">
			  <div class="media-body">
			    <h5 class="mt-0">Center-aligned media</h5>
			    <p>Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis. Fusce condimentum nunc ac nisi vulputate fringilla. Donec lacinia congue felis in faucibus.</p>
			    <p class="mb-0">Donec sed odio dui. Nullam quis risus eget urna mollis ornare vel eu leo. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</p>
			  </div>
			</div>
			<div class="media mt-3 mb-3">
			  <img src="images/tour/Halong-bay.jpeg" class="align-self-center mr-3" alt="..." style="width: 200px; height: 200px;  object-fit: cover;">
			  <div class="media-body">
			    <h5 class="mt-0">Center-aligned media</h5>
			    <p>Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis. Fusce condimentum nunc ac nisi vulputate fringilla. Donec lacinia congue felis in faucibus.</p>
			    <p class="mb-0">Donec sed odio dui. Nullam quis risus eget urna mollis ornare vel eu leo. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</p>
			  </div>
			</div>
			
	    </div>
    </div>
	</body>
</html>