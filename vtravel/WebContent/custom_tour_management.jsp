<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Quản lý đặt Custom Tour </title>
	<!-- Thư viện CSS Bootstrap -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<!-- Thêm script của Bootstrap Modal -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.2/js/bootstrap.bundle.min.js"></script>
	<!-- script hiển thị pop up -->
	 <script src="js/pop-up.js"></script>  
  	<link rel="stylesheet" href="css/pop-up.css"> 
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
  	
   <!-- script xử lý thao tác -->
 	<script src="js/custom_tour_management.js"></script>   
	
 
 
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
		<h3>Danh sách đơn Custom Tour</h3>
		<!-- tạo link gửi yêu cầu hiển thị danh sách  -->
		<c:url var="LIST_ALL_CUSTOM_TOUR_REQUEST" value="TourControllerServlet">
			<c:param name="command" value="LIST_ALL_CUSTOM_TOUR_REQUEST" />
		</c:url>
		<a href="${LIST_ALL_CUSTOM_TOUR_REQUEST}" class="btn btn-primary mb-2 btn-sm">Tải DS Custom Tour</a>
		
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
			<!-- Nút phân trang -->
		 <div id="pagination">
		    <button onclick="previousPage()" class="btn btn-md btn-outline-primary">Previous Page</button>
		    <span id="currentPage">1</span>
		    <button onclick="nextPage()" class="btn btn-md btn-outline-primary">Next Page</button>
		</div> 
			<div class="input-group col-md-3 mb-3 ml-auto ">
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
			
		    <div class="input-group mb-3 col-md-3 " >
			  <div class="input-group-prepend">
			    <span class="input-group-text" >Tìm kiếm</span>
			  </div>
			  <input type="text" class="form-control" id="searchInput" name="search" placeholder="VD: Nha Trang"   oninput="searchData('data-search-1','data-search-2')">
			</div>
			
		</div>

		<!-- bảng booking -->
		<table id="InfoTable" class="table">
			<thead>
				<tr>
					<th>STT</th>
					<th>Điểm du lịch</th>
					<th>Tên khách đặt</th>
					<th> Số lượng khách</th>
					<th> Ngày bắt đầu</th>
					<th> Ngày kết thúc</th>
					<th>Ngày đặt</th>
					<th>Trạng thái</th>
					<th>Hành động</th>
				</tr>
			</thead>
			<tbody id="InfoBody">
				<c:forEach items="${PROPOSAL_LIST}" var="tempProposal" varStatus="loopStatus">
					<tr class="row-item" data-search-1="${tempProposal.ordererFullname}" data-search-2="${tempProposal.destination}" status="${tempProposal.status}">
						<td>${loopStatus.index + 1}</td>
						<td>${tempProposal.destination}</td>
						<td>${tempProposal.ordererFullname}</td>
			 			<td>${tempProposal.numberOfTravellers}</td>
						<td>${tempProposal.startDate}</td>
						<td>${tempProposal.endDate}</td>
						<td>${tempProposal.createdDate}</td>
						<td id="status_${tempProposal.ID}">${tempProposal.status}</td>
			 			<!-- set up a link to delete a tour  -->
			 			<c:url var="deleteLink" value ="TourControllerServlet">
			 				<c:param name="command" value="DELETE"/>
			 				<c:param name="tourID" value="${tempTour.id}"/>
			 			</c:url>		 		
						<td>
							<!-- tạo link xem chi tiết và phản hồi yêu cầu custom tour  -->
				 			<c:url var="DETAIL_PROPOSAL" value ="TourControllerServlet">
				 				<c:param name="command" value="DETAIL_PROPOSAL"/>
				 				<c:param name="ID" value="${tempProposal.ID}"/>
				 				<c:param name ="ordererID" value = "${tempProposal.ordererID}"/>
				 			</c:url>	
							<a  class="btn btn-primary btn-sm"  onclick="showPopup('${DETAIL_PROPOSAL}')">Xử lý</a> 
							<!-- Thực hiện thao tác sẽ làm thay đổi trạng thái nên cần cập nhật lại chức năng lọc -->
							<a class="btn btn-success btn-sm" onclick="confirmAndPurchase('${tempProposal.destination}', '${tempProposal.ordererFullname}', ${tempProposal.ID})">Đã thanh toán</a>
							<a class="btn btn-danger btn-sm" onclick="confirmAndCancel('${tempProposal.destination}', '${tempProposal.ordererFullname}', ${tempProposal.ID})">Huỷ</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		
		<!-- Truyền giá trị PROPOSAL_LIST.size() vào một thuộc tính HTML -->
		<div id="proposalListSize" data-size="${PROPOSAL_LIST.size()}"></div>
		
		<!-- Javascript xử lý phân trang và tìm kiếm -->
		 <script src="js/pagination_and_search.js"></script>  
	</div>
</body>
</html>