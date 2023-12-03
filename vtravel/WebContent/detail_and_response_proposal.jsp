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
		<h3>Phản hồi đơn đặt chuyến tuỳ chọn</h3>
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
			
			<div class = "row">
				<div class="col-md-6">
					<div class= "form-group">
				 		<label for="destination">Địa điểm:</label>
				 		<input type="text" class="form-control" id="destination" name="destination" placeholder="VD: Nha Trang" value="${PROPOSAL.destination}"   >
					</div>
				</div>
				<div class = "col-md-6">
					<div class="form-group">
		                <label for="number_of_travaller" style="font-size:17px">Số lượng người</label>
		                <input type="number" class="form-control" id="number_of_traveller" name="number_of_traveller" required min = "1"
		                title = "Số lượng du khách tối thiểu là 1" value="${PROPOSAL.numberOfTravellers}">
			     	</div>
				</div>
			</div>
			<div class="row">
				<div class = "col-md-6">
					 <!-- Phần chọn ngày bắt đầu, kết thúc và xử lý ngày hợp lệ -->
			         <div class="form-group">
			            <label for="start_date">Ngày bắt đầu:</label>
			            <input type="date" class="form-control" id="start_date" name="start_date"  
			              title="Ngày bắt đầu sau hiện tại tối thiểu 1 tuần" required value = "${PROPOSAL.startDate }">
			         </div>  
				</div>
				<div class = "col-md-6">
					<div class="form-group" >
		            	<label for="end_date">Ngày kết thúc:</label>
		            	<input type="date" class="form-control" id="end_date" name="end_date"  
		              		title="Chọn ngày kết thúc sau ngày bắt đầu" required value = "${PROPOSAL.endDate}">
					</div>
				</div>
			</div>
			<div class = "row">
				<div class = "col-md-6">
					<div class="form-group">
			            <label for="price">Giá (VNĐ): </label>
			            <input type="number" class="form-control" id="price" name="price" placeholder="VD: 5000000" required 
			      		 title="Vui lòng nhập giá chuyến du lịch ">
		          </div>
				</div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="created_date">Ngày đặt: </label>
						<input  type = "text" class="form-control" value = "${PROPOSAL.createdDate}" readonly>
					</div>
				</div>
			</div>
			<!-- Phần mô tả -->
			<div class="form-group">
				<label for="description">Mô tả chi tiết:</label>
				<textarea id="descriptionTextarea" class="form-control"
					name="description">${PROPOSAL.note}</textarea>
				<script>
					  ClassicEditor
					    .create(document.querySelector('#descriptionTextarea'))
					    .catch(error => {
					      console.error(error);
		   			 });
				</script>
			</div>
			
			<!-- Phần nút  -->
			<div class="btn-toolbar justify-content-end" style ="position: fixed; bottom: 20px; right: 50px">

				<!-- Đóng form lại -->

				<a class="btn btn-secondary mr-2" onclick="window.parent.hidePopup()">Đóng</a>
				
				<!-- Gửi submit form -->
				<button type="submit" class="btn btn-success ml-1" id="updateBtn" >Phản hồi</button>
			
			
			</div>
		</form>
	</div>
</body>
</html>