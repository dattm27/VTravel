<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- để định dạng số tiền -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>VTravel - Danh sách Tour</title>
	<!-- Bootstrap CSS -->
	  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<!-- Include phần navbar   -->
	 <jsp:include page="navbar.jsp" />
	<div class="container-fluid mt-3">
    <div class="row">

        <!-- Sidebar để hiển thị công cụ lọc tour -->
        <nav class="col-md-2 d-none d-md-block bg-light sidebar sticky-top">
            <div class="sidebar-sticky">
                <h5>Lọc tour</h5>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="#">
                            Filter 1
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                           Filter  2
                        </a>
                    </li>
                    <!-- Add more links as needed -->
                </ul>
            </div>
        </nav>

        <!-- Main Content: Hiển thị danh sách các tour -->
        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
            <h2>Tour phổ thông</h2>
            <!-- Hộp tìm kiếm theo tên tour  -->
            <div class="input-group mb-3 mt-3 col-md-4 mr-auto " >
			  <div class="input-group-prepend">
			    <span class="input-group-text" >Tìm kiếm</span>
			  </div>
			  <input type="text" class="form-control" id="searchInput" name="search" placeholder="VD: Nha Trang"   oninput="searchData('data-search-1','data-search-2')">
			</div>
            <div class = "d-flex justify-content-around flex-wrap">	 
	       	   <!-- Vòng lặp for hiển thị danh sách các tour -->
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
        </main>
    </div>
</div>
</body>
</html>