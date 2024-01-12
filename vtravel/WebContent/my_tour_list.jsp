<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- để định dạng số tiền -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Tour của tôi</title>
	<!-- Thư viện CSS Bootstrap -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Thêm script của Bootstrap Modal -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.2/js/bootstrap.bundle.min.js"></script>
    <!-- script hiển thị pop up -->
	 <script src="js/pop-up.js"></script>  
	 <link rel="stylesheet" href="css/pop-up.css"> 
	  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	  <style>
	    #popup-iframe {
	        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen-Sans, Ubuntu, Cantarell, "Helvetica Neue", sans-serif;
	    }
	</style>
</head>
<body>
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
	
	<div class = "ml-5 mt-3 mr-5 d-flex flex-row">
		<h2>Danh sách tour đã đặt</h2>
		
	    <div class="input-group mb-3 col-md-3 ml-auto " >
		  <div class="input-group-prepend">
		    <span class="input-group-text" >Tìm kiếm</span>
		  </div>
		  <input type="text" class="form-control" id="searchInput" name="search" placeholder="VD: Nha Trang"    oninput="searchData('data-search-1','data-search-2')">
		</div>
		
	</div>
		<ul class="ml-5 mb-3 nav nav-pills">
		  <li class="nav-item">
		    <a id="TourPhoThongTab" class="nav-link active"  onclick="showTab('TourPhoThong');searchData('data-search-1','data-search-2')">Tour phổ thông</a>
		  </li>
		  <li class="nav-item">
		    <a id="TourTuyChonTab"  class="nav-link" onclick="showTab('TourTuyChon');searchData('data-search-1','data-search-2')">Tour tuỳ chọn</a>
		  </li>
		  <li class="nav-item">
		    <a  id="KenhThanhToanTab" class="nav-link" onclick="showTab('KenhThanhToan');searchData('data-search-1','data-search-2')">Thanh toán</a>
		  </li>
		</ul>
		<!-- Danh sách các tour phổ thông đã đặt -->
	<div class="ml-5 mr-5">
		<div id="TourPhoThong" class="tab-content" style="display: block;" >
			<h3 class="">Tour phổ thông</h3>
			<table id="InfoTable" class="table" >
				<thead>
					<tr>
						<th>Mã đơn</th>
						<th>Tên chuyến</th>
						<th>Số lượng đặt</th>
						<th>Thời gian đặt</th>
						<th>Thành tiền</th>
						<th>Điểm đón</th>
						<th>Trạng thái</th>
	
	
					</tr>
				</thead>
				<tbody id="InfoBody">
					<c:forEach items="${myBookings}" var="booking" varStatus="loopStatus">
						<tr class="row-item" data-search-1="${booking.tourName}"
							data-search-2="${booking.userFullname}"
							status="${tempProposal.status}">
							<td>${booking.ID}</td>
							<c:url var="DETAIL_TOUR_PAGE" value="TourControllerServlet">
								<c:param name="command" value="DETAIL_TOUR_PAGE"></c:param>
								<c:param name="ID" value="${booking.tourID}"></c:param>
							</c:url>
							<td style="max-width: 200px"><a href="${DETAIL_TOUR_PAGE}">${booking.tourName}</a></td>
							<td>${booking.numberOfTourists}</td>
							<td>${booking.createdDate}</td>
							<td><fmt:formatNumber type="number" maxFractionDigits="2"
									value="${booking.totalBill}" /></td>
							<td style="max-width: 200px">${booking.note}</td>
							<td id="status_${booking.ID}">${booking.status}</td>
	
	
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- Danh sách các tour tuỳ chọn đã đặt -->
		<div id="TourTuyChon" class="tab-content" style="display: none;">
			<h3>Tour tuỳ chọn</h3>
			<table id="InfoTable"  class="table" >
				<thead>
					<tr>
						<th>Mã đơn</th>
						<th>Điểm du lịch</th>
						<th> Số lượng khách</th>
						<th> Ngày bắt đầu</th>
						<th> Ngày kết thúc</th>
						<th>Ngày đặt</th>
						<th>Chi tiết</th>
						<th>Thành tiền</th>
						<th>Trạng thái</th>
				
					</tr>
				</thead>
				<tbody id="InfoBody">
					<c:forEach items="${myCustomTours}" var="customTour" varStatus="loopStatus">
						<tr class="row-item" data-search-1="${customTour.destination}" data-search-2="${tempProposal.destination}">
							<td>${customTour.ID}</td>
							<td>${customTour.destination}</td>
						
				 			<td>${customTour.numberOfTravellers}</td>
							<td>${customTour.startDate}</td>
							<td>${customTour.endDate}</td>
							<td>${customTour.createdDate}</td>
							<td> 
								<c:if test="${customTour.status ne 'Đang chờ'}">
							   		<a class="link" onclick="openPopup('${customTour.note}')">Mô tả chi tiết</a>
								 </c:if>
								  <c:if test="${customTour.status eq 'Đang chờ'}">
								    Chưa có
								  </c:if>
							</td>
							<td>
								<c:if test="${customTour.status ne 'Đang chờ'}">
							   		<fmt:formatNumber type="number" maxFractionDigits="2" value="${customTour.price}" />
								 </c:if>
								<c:if test="${customTour.status eq 'Đang chờ'}">
									Chưa có
								</c:if>
							</td>
							<td id="status_${customTour.ID}">${customTour.status}</td>
				 		
						</tr>
					</c:forEach>
				</tbody>
			</table>
		
		</div>
		
		
		<!-- Thông tin thanh toán -->
		<div id="KenhThanhToan"  class="tab-content" style="display: none;">
			<h3>Kênh thanh toán</h3>
			<div class="row row-cols-1 row-cols-md-4 g-4 mb-3">
				<div class="col">
					<div class="card h-60">
						<img src="images/QRBIDV.JPG" class="card-img-top" alt="..."
							style="height: 280px">
						<div class="card-body">
							<h5 class="card-title">BIDV</h5>
							<div>STK: 4430394543</div>
							<div>CTK: TRAN MANH DAT</div>
						</div>
					</div>
				</div>
				<div class="col">
					<div class="card h-60">
						<img src="images/QRMB.jpeg" class="card-img-top" alt="..."
							style="height: 280px">
						<div class="card-body">
							<h5 class="card-title">MB</h5>
							<div>STK: 0827666910</div>
							<div>CTK: TRAN MANH DAT</div>
						</div>
					</div>
				</div>
				<div class="col">
					<div class="card h-60">
						<img src="images/QRTECHCOMBANK.jpg" class="card-img-top" alt="..."
							style="height: 280px">
						<div class="card-body">
							<h5 class="card-title">TECHCOMBANK</h5>
							<div>STK: 1903 9944 7520 18</div>
							<div>CTK: PHAN VIET HOANG</div>
						</div>
					</div>
				</div>
				<div class="col">
					<div class="card h-60">
						<img src="images/QRVIETINBANK.jpg" class="card-img-top" alt="..."
							style="height: 280px">
						<div class="card-body">
							<h5 class="card-title">VIETINBANK</h5>
							<div class="card-text">STK: 102873396890</div>
							<div>CTK: TRAN DANH LINH</div>
						</div>
					</div>
				</div>
			</div>
			<p><strong>Nội dung chuyển khoản:</strong> Mã đơn SĐT</p>
			<div class="alert alert-danger" role="alert">
			  Trong 24 giờ kể từ khi thanh toán, nhân viên Viet Travel sẽ kiểm tra tài khoản và xác nhận "Đã thanh toán" cho đơn đặt của bạn.
			</div>
			
		</div>
		</div>
		
	<script>
	    function showTab(tabId) {
	    	//xoá ô tìm kiếm
			document.getElementById("searchInput").value = "";
	 
	    	//bỏ active khỏi các thẻ khác
	    	var tabLinks = document.getElementsByClassName('nav-link');
	    	
	        for (var i = 0; i < tabLinks.length; i++) {
	            tabLinks[i].classList.remove('active');
	        }

	        // Thêm class 'active' cho tab được chọn
	        document.getElementById(tabId + 'Tab').classList.add('active');
	        
	    	// Ẩn tất cả các tab-content
	        var tabContents = document.getElementsByClassName('tab-content');
	        for (var i = 0; i < tabContents.length; i++) {
	            tabContents[i].style.display = 'none';
	        }
	        // Hiển thị tab-content tương ứng với tab được chọn
	        document.getElementById(tabId).style.display = 'block';
	       
	    }
	    function openPopup(note) {
	    	  // Hiển thị popup
	    	  document.getElementById("popup").style.display = "block";

	    	  // Truyền giá trị vào iframe
	    	  var encodedNote = encodeURIComponent(note);
	    	  var iframe = document.getElementById("popup-iframe");
	    	  iframe.src = "data:text/html;charset=utf-8," + encodedNote;;
	    	}
	</script>
	<!-- tìm kiếm -->
	<script src="js/pagination_and_search.js"></script>  
</body>
</html>