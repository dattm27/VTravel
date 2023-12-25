<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Phản hồi đơn đặt chuyến tuỳ chọn</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<!-- Thêm script của Bootstrap Modal -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.2/js/bootstrap.bundle.min.js"></script>
	 <!-- Script cho công cụ chỉnh sửa textera -->
	<script src="https://cdn.ckeditor.com/ckeditor5/31.1.0/classic/ckeditor.js"></script>	
	
</head>
<body>
	<div class="container">
		 <%
			String Message = (String) request.getAttribute("Message");
		 	
		 	if (Message != null) {
				
			%>
		<h3 class= "text-success">Phản hồi thành công</h3>
		<%} else {%>
		<h3>Phản hồi đơn đặt chuyến tuỳ chọn</h3>
		<%} %>
		<h4>1. Thông tin khách hàng</h4>
		<form>
			<div class="row">
		        <div class="col-md-6">
		          <div class="form-group">
		            <label for="name">ID khách hàng:</label>
		            <input type="text" class="form-control" value="${ORDERER.ID}" readonly>
		          </div>
		        </div>
		        <div class="col-md-6">
		          <div class="form-group">
		            <label for="name">Tên khách hàng:</label>
		            <input type="text" class="form-control" value="${ORDERER.fullname}" readonly>
		          </div>
		        </div>
		       
	      </div>
	      <div class = "row">
				<div class="col-md-6">
					<div class="form-group">
						<label for="phoneNumber">Số điện thoại: </label> <input type="tel"
							class="form-control" name="phoneNumber"
							value="${ORDERER.phoneNumber}" readonly>
					</div>
				</div>
				<div class="col-md-6">
					<label for="email">Email:</label> <input type="email"
						class="form-control" value="${ORDERER.email}" readonly>
				</div>
			</div>
		</form>
		<h4>2. Thông tin chuyến tuỳ chọn</h4>
		<form  action="TourControllerServlet" method ="POST">
			<!-- Những thông tin ẩn của form -->
			<input type="hidden" name = "command" value ="REPONSE_TO_PROPOSAL">
			<input type="hidden" name ="ID" value="${PROPOSAL.ID}">
			<input type="hidden" name ="userID" value="${ORDERER.ID}">
			<div class = "row">
				<div class="col-md-6">
					<div class= "form-group">
				 		<label for="destination">Địa điểm:</label>
				 		<input type="text" class="form-control" id="destination" name="destination" placeholder="VD: Nha Trang" value="${PROPOSAL.destination}"  ${Message != null ? 'readonly' : ''} >
					</div>
				</div>
				<div class = "col-md-6">
					<div class="form-group">
		                <label for="number_of_travaller" style="font-size:17px">Số lượng người</label>
		                <input type="number" class="form-control" id="number_of_traveller" name="number_of_traveller" required min = "1"
		                title = "Số lượng du khách tối thiểu là 1" value="${PROPOSAL.numberOfTravellers}" ${Message != null ? 'readonly' : ''} >
			     	</div>
				</div>
			</div>
			<div class="row">
				<div class = "col-md-6">
					 <!-- Phần chọn ngày bắt đầu, kết thúc và xử lý ngày hợp lệ -->
			         <div class="form-group">
			            <label for="start_date">Ngày bắt đầu:</label>
			            <input type="date" class="form-control" id="start_date" name="start_date"  
			              title="Ngày bắt đầu sau hiện tại tối thiểu 1 tuần" required value = "${PROPOSAL.startDate }" ${Message != null ? 'readonly' : ''}>
			         </div>  
				</div>
				<div class = "col-md-6">
					<div class="form-group" >
		            	<label for="end_date">Ngày kết thúc:</label>
		            	<input type="date" class="form-control" id="end_date" name="end_date"  
		              		title="Chọn ngày kết thúc sau ngày bắt đầu" required value = "${PROPOSAL.endDate}" ${Message != null ? 'readonly' : ''}>
					</div>
				</div>
			</div>
			<div class = "row">
				<div class = "col-md-6">
					<div class="form-group">
			            <label for="price">Giá (VNĐ): </label>
			            <input type="number" class="form-control" id="price" name="price" placeholder="VD: 5000000" required 
			      		 min = "1" title="Vui lòng nhập giá chuyến du lịch " value = "${PROPOSAL.price}" ${Message != null ? 'readonly' : ''}>
		          </div>
				</div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="created_date">Ngày đặt: </label>
						<input  type = "text" class="form-control" name = "created_date" value = "${PROPOSAL.createdDate}" readonly>
					</div>
				</div>
			</div>
			<!-- Phần mô tả -->
			<div class="form-group">
				<label for="description">Mô tả chi tiết:</label>
				<c:if test="${Message == null}">
				    <textarea id="descriptionTextarea" class="form-control" name="description">${PROPOSAL.note}</textarea>
				    <script>
				        ClassicEditor
				            .create(document.querySelector('#descriptionTextarea'))
				            .catch(error => {
				                console.error(error);
				            });
				    </script>
				</c:if>
				<c:if test="${Message != null}">
				   <div class ="border rounded p-2 bg-light" >
				   		${PROPOSAL.note}
				   </div>
				</c:if>
			</div>
			
			<!-- Phần nút  -->
			<div class="btn-toolbar justify-content-end" style ="position: fixed; bottom: 20px; right: 50px">

				<!-- Đóng form lại -->
				
				<a class="btn btn-secondary mr-2" onclick="window.parent.hidePopup()">Đóng</a>
				
				<!-- Gửi submit form -->
				 <%
				 	if (Message == null) {
				%>
				<button type="submit" class="btn btn-success ml-1" id="updateBtn" >Phản hồi</button>
				<%} else {  %>
				<!-- tạo link gửi yêu cầu hiển thị danh sách  -->
				<c:url var="LIST_ALL_CUSTOM_TOUR_REQUEST" value="TourControllerServlet">
					<c:param name="command" value="LIST_ALL_CUSTOM_TOUR_REQUEST" />
				</c:url>
				<a class = "btn btn-primary ml-1" href="${LIST_ALL_CUSTOM_TOUR_REQUEST}" target="_parent" >Tải lại DS</a>
				<%} %>
			</div>
		</form>
	</div>
	

</body>
</html>