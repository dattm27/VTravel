<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- để định dạng số tiền -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>VTravel - Tour phổ thông</title>
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
                       
						  <form class="row align-items-center">
								<input type = "hidden" name = "command" value = "LIST_ALL_TOURS">
								<%-- <div class="input-group  mb-3 ml-3">
								  
								  <select class="form-select"   id="inputGroupSelect01" style="" name = "kieu_sap_xep" >
								    <option selected style="margin-left: 30px;"> <%= request.getParameter("kieu_sap_xep") == null ? "Giá tăng dần" : (request.getParameter("kieu_sap_xep").equals("1") ? "Giá tăng dần" : (request.getParameter("kieu_sap_xep").equals("2") ? "Giá giảm dần" : "Ngày xuất phát")) %> </option>
								    <option value="1">Giá tăng dần</option>
								    <option value="2">Giá giảm dần</option>
								    <option value="3">Ngày xuất phát</option>
								  </select>
								</div>	 --%>
								 <select class="custom-select ml-3 mr-3 mb-3" id="inputGroupSelect01" name = "kieu_sap_xep" >
								    <option selected value="Chọn bộ lọc" disabled><%= request.getParameter("kieu_sap_xep") == null ? "Chọn bộ lọc" : (request.getParameter("kieu_sap_xep").equals("1") ? "Giá tăng dần" : (request.getParameter("kieu_sap_xep").equals("2") ? "Giá giảm dần" : "Ngày xuất phát")) %> </option>
								    <option value="1">Giá tăng dần</option>
								    <option value="2">Giá giảm dần</option>
								    <option value="3">Ngày xuất phát</option>
								  </select>
								
								
								<div class="col-auto">
									<label class="visually" for="autoSizingInput">Điểm đến</label> <input
										type="text" name = "diemmuonden" class="form-control" id="autoSizingInput"
										placeholder="Điểm đến" value="<%= request.getParameter("diemmuonden") == null ? "" : request.getParameter("diemmuonden") %>">
								</div>
								<div class="col-auto">
									<label class="visually" for="autoSizingInput">Ngày bắt đầu</label> <input
										type="date" name = "ngay_bat_dau" class="form-control" id="autoSizingInput"
										placeholder="22-12-2023" value="<%= request.getParameter("ngay_bat_dau") == null ? "" : request.getParameter("ngay_bat_dau")%>">
								</div>
								<div class="col-auto">
									<label class="visually" for="autoSizingInput">Tầm giá mong muốn</label> <input
										type="text" name = "gia_mong_muon" class="form-control" id="autoSizingInput"
										placeholder="Giá tiền" value="<%= request.getParameter("gia_mong_muon") == null ?  "" : request.getParameter("gia_mong_muon") %>">
								</div>
								
								
								<div class="col-auto mt-auto" >
									<button type="submit" class="btn btn-primary" style="margin-top: 20px;">Lọc</button>
								</div>
							</form>
                   
                    </li>
                    <!-- Add more links as needed -->
                </ul>
            </div>
        </nav>

        <!-- Main Content: Hiển thị danh sách các tour -->
        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
            <h2>Tour phổ thông</h2>
            <!-- Hộp tìm kiếm theo tên tour  -->
            <!--<div class="input-group mb-3 mt-3 col-md-4 mr-auto " >
			  <div class="input-group-prepend">
			    <span class="input-group-text" >Tìm kiếm</span>
			  </div>
			  <input type="text" class="form-control" id="searchInput" name="search" placeholder="VD: Nha Trang"   oninput="searchData('data-search-1','data-search-2')">
			</div>-->
            <div class = "d-flex justify-content-around flex-wrap">	 
	       	   <!-- Vòng lặp for hiển thị danh sách các tour -->
	       	   <c:forEach items="${TOUR_LIST}" var="tour">
			        <div class="card mb-3" style="width: 16rem;">
					  <img class="card-img-top" src="images/tour/Halong-bay.jpeg" alt="Card image cap">
					  <div class="card-body">
					  <c:url var="DETAIL_TOUR_PAGE" value ="TourControllerServlet">
					  	<c:param name="command" value = "DETAIL_TOUR_PAGE"/>
					  	<c:param name="ID" value = "${tour.ID}"/>
 					  </c:url>
					    <h5 class="card-title"><a href="${DETAIL_TOUR_PAGE}">${tour.name}</a></h5>
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