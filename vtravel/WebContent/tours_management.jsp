<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- để định dạng số tiền -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">	
	<title>Quản lý Tour phổ thông</title>
	<!-- Thư viện CSS Bootstrap -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<!-- Thêm script của Bootstrap Modal -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.2/js/bootstrap.bundle.min.js"></script>
	<!-- script hiển thị pop up -->
	 <script src="js/pop-up.js"></script>  
  	<link rel="stylesheet" href="css/pop-up.css"> 
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
  	
   <!-- script xử lý các thao tác của custom tour-->
 	<script src="js/tour_management.js"></script>   
	
</head>
<body>
	<!-- <div class= "ml-5">	<a href="index.jsp">Trang chủ</a></div> -->
	<!--Thêm navbar -->
	<jsp:include page="navbar.jsp" />
	<!-- Phần pop up-->
	<div id="popup" class="popup" style="display: none">
		<div class="iframe-container">
			<!-- nút đóng -->
			<button type="button" class="btn btn-primary btn-circle close-icon"
				data-dismiss="modal" onclick="hidePopup()">
				<i class="fas fa-times"></i>
			</button> 
			<!-- iframe để hiển thị trang khác trong pop up -->
			<iframe id="popup-iframe" src="" width="100%" height="650px"></iframe>
			
		</div>
	</div>
	
	<div class="ml-5 mr-5">
		<h3>Danh sách Tour phổ thông</h3>
		<!-- tạo link gửi yêu cầu hiển thị danh sách  -->
		<c:url var="TOURS_MANAGEMENT" value="TourControllerServlet">
			<c:param name="command" value="TOURS_MANAGEMENT" />
		</c:url>
		<a href="${TOURS_MANAGEMENT}" class="btn btn-primary mb-2 btn-sm">Tải DS Tour phổ thông</a>
		<!-- tạo nút tạo tour mới -->
		<button  class="btn btn-success mb-2 btn-sm" onclick="showPopup('add_new_tour.jsp')">Thêm Tour mới</button>
		<!-- Phần phân trang và tìm kiếm -->
		<div class="row">
		    <!-- Chọn số bản ghi mỗi trang -->
		    <div class="input-group col-md-3 mb-3 ">
			    <div class="input-group-prepend">
			        <label for="recordsPerPage" class="input-group-text">Số bản ghi/trang:</label>
			        <select class="custom-select" id="recordsPerPage" onchange="changeRecordsPerPage()">
			            <option value="all">Hiển thị tất cả</option>
			            <option value="1">1</option>
			            <option value="5">5</option>
			            <option value="10" selected>10</option>
			            <option value="20">20</option>
			        </select>
			    </div>
			  </div>
			
			<div class="input-group col-md-3 mb-3  " style = "display: none">
			  <div class="input-group-prepend">
			    <label class="input-group-text" for="Filter">Lọc</label>
			  </div>
			  <select class="custom-select" id="Filter" onchange="filterByStatus()">
			    <option selected value="Chọn trạng thái" disabled>Chọn trạng thái</option>
			    <option value="Đang chờ">Đang chờ</option>
			    <option value="Chờ thanh toán">Chờ thanh toán</option>
			    <option value="Đã thanh toán">Đã thanh toán</option>
			    <option value="Đã huỷ">Đã huỷ</option>
			    <option value ="Chọn trạng thái">Tất cả </option>
			  </select>
			</div>
			<!-- Nút phân trang -->
			 <div id="pagination">
			    <button onclick="previousPage()" class="btn btn-md btn-outline-primary">Previous Page</button>
			    <span id="currentPage">1</span>
			    <button onclick="nextPage()" class="btn btn-md btn-outline-primary">Next Page</button>
			</div> 
		    <div class="input-group mb-3 col-md-3 ml-auto " >
			  <div class="input-group-prepend">
			    <span class="input-group-text" >Tìm kiếm</span>
			  </div>
			  <input type="text" class="form-control" id="searchInput" name="search" placeholder="VD: Nha Trang"   oninput="searchData('data-search-1','data-search-2')">
			</div>
			
			<div class="input-group col-md-2 mb-3  " >
			  <div class="input-group-prepend">
			    <label class="input-group-text" for="Filter">Sắp xếp</label>
			  </div>
			  <select class="custom-select" id="Filter" onchange="filterByStatus()">
			    <option selected value="Chọn trạng thái" disabled>Chọn </option>
			    <option value="Đang chờ">Theo giá</option>
			    <option value="Chờ thanh toán">Theo ngày bắt đầu</option>
			   
			    <option value ="Chọn trạng thái">Tất cả </option>
			  </select>
			</div>
			
		</div>

		<!-- bảng booking -->
		<table id="InfoTable" class="table">
			<thead>
				<tr>
					<th>STT</th>
					<th>Tên chuyến</th>
					<th>Ngày bắt đầu</th>
					<th> Ngày kết thúc</th>
					<th>Ảnh</th>
					<th>Giá vé</th>
					<th>Đã đặt</th>
					<th>Hành động</th>
				</tr>
			</thead>
			<tbody id="InfoBody">
				<c:forEach items="${TOUR_LIST}" var="tour" varStatus="loopStatus">
					<tr class="row-item" data-search-1="${tour.name}" data-search-2="${tour.startPlace}" status="${tempProposal.status}" id = "ID_${tour.ID}">
						<td>${loopStatus.index + 1}</td>
						<td style="max-width: 200px">${tour.name}</td>
						<td>${tour.startDate}</td>
			 			<td>${tour.endDate}</td>
						<td><img src="${tour.image}" style="max-width: 150px" alt= "Ảnh minh hoạ"></td>
						<td><fmt:formatNumber type="number" maxFractionDigits="2" value="${tour.price}" /></td>
						<td>${tour.booked}</td>
			 			<!-- set up a link to delete a tour  -->
			 			<c:url var="deleteLink" value ="TourControllerServlet">
			 				<c:param name="command" value="DELETE"/>
			 				<c:param name="tourID" value="${tempTour.id}"/>
			 			</c:url>		 		
						<td>
							<!-- tạo link xem chi tiết và sửa thông tin tour -->
				 			<c:url var="DETAIL_AND_UPDATE_TOUR" value ="TourControllerServlet">
				 				<c:param name="command" value="DETAIL_AND_UPDATE_TOUR"/>
				 				<c:param name="ID" value="${tour.ID}"/>
				 				
				 			</c:url>	
							<a  class="btn btn-primary btn-sm"  onclick="showPopup('${DETAIL_AND_UPDATE_TOUR}')">Chi tiết/ Sửa</a> 
							<!-- tạo link xem danh sách đặt của từng tour -->
							<c:url var = "BOOKING_LIST_OF_A_TOUR" value = "TourControllerServlet">
								<c:param name= "command" value = "BOOKING_LIST_OF_A_TOUR"/>
								<c:param name= "tourID" value = "${tour.ID}"/>
							</c:url>
							<a class="btn btn-success btn-sm" href="${BOOKING_LIST_OF_A_TOUR}">Danh sách đặt</a>
							<!-- <a class="btn btn-warning btn-sm">Khoá</a> -->
							
							<a class="btn btn-danger btn-sm" onclick="confirmAndDelete(${tour.ID})">Xoá</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		
		<!-- Truyền giá trị PROPOSAL_LIST.size() vào một thuộc tính HTML -->
		<div id="proposalListSize" data-size="${TOUR_LIST.size()}"></div>
		
		<!-- Javascript xử lý phân trang và tìm kiếm -->
		 <script src="js/pagination_and_search.js"></script>  
	</div>
	
</body>
</html>