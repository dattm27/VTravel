<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Thêm tour phổ thông mới</title>
	<!-- CSS Bootstrap -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<!-- Editor cho description -->
	<script src="https://cdn.ckeditor.com/ckeditor5/31.1.0/classic/ckeditor.js"></script>	
</head>
<body>
	<div class = "container">
		 <%
			String Message = (String) request.getAttribute("message");
		 	
		 	if (Message != null) {
				
			%>
		<h3 class= "text-success">Thêm tour thành công</h3>
		<%} else {%>
		<h3>Thêm tour phổ thông</h3>
		<%} %>
		 <form action="TourControllerServlet" method="POST" id="addTourForm"
			enctype="multipart/form-data">
			<input type="hidden" name="command" value="ADD_NEW_TOUR">
			<input type="hidden" name="id" >
			<div class="row">
				<div class="col-md-6">
					<div class="form-group">
						<label for="name">Tên chuyến du lịch:</label> <input type="text"
							class="form-control" id="name" name="name"
							placeholder="VD: Du lịch Nha Trang" required >
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="price">Giá (VNĐ): </label> <input type="number"
							class="form-control" id="price" name="price"
							placeholder="VD: 5000000" required pattern="[0-9]"
					 title="Vui lòng nhập giá chuyến du lịch ">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<div class="form-group">
						<label for="start_date">Ngày bắt đầu:</label> <input type="date"
							class="form-control" id="start_date" name="start_date"
							title="Chọn ngày bắt đầu sau ngày hiện tại" required
							>
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="end_date">Ngày kết thúc:</label> <input type="date"
							class="form-control" id="end_date" name="end_date"
							title="Chọn ngày kết thúc sau ngày bắt đầu" required>
						<!-- chỉ cho phép chọn sau khi chọn ngày bắt đầu, ngày kết thúc phải sau ngày bắt đầu -->
						<script>
						 var startDateInput = document.getElementById("start_date");
				            var endDateInput = document.getElementById("end_date");
				            
				            startDateInput.addEventListener("change", function() {
				                var startDate = new Date(startDateInput.value);
				                var endDate = new Date(endDateInput.value);
				                
				                if (endDate && endDate <= startDate) {
				                    endDateInput.value = ""; // Reset ngày kết thúc nếu không hợp lệ
				                }
				                
				                endDateInput.min = startDateInput.value; // Cập nhật ngày nhỏ nhất cho ngày kết thúc
				            });
						</script>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<div class="form-group">
						<label for="start_place">Điểm khởi hành:</label> <input type="text"
							class="form-control" id="start_place" name="start_place"
							placeholder="Nhập địa chỉ" required >
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group">
						<label for="imageUpload" id="imageUpload">Tải lên ảnh:</label>
						<div class="custom-file">
							<input type="hidden" name = "oldImage" />
							<input type="file" class="custom-file-input" id="image"
								name="image"> <label class="custom-file-label"
								for="image" id="fileUpload">${tour.image.substring(tour.image.indexOf('_') + 1, tour.image.indexOf('_') + 1 + Math.min(30, tour.image.length() - tour.image.indexOf('_') - 1))}</label>
						</div>
						<script>
							// kiểm tra nếu không có tên file thì ghi ra là chưa chọn tệp	
							var fileUpload =	document.getElementById("fileUpload");
							if (fileUpload.innerHTML ==="") fileUpload.innerHTML = "Chưa chọn tệp";
									
						
							const fileInput = document.getElementById('image');
						  	const fileLabel = document.querySelector('.custom-file-label');
						
						 	fileInput.addEventListener('change', (event) => {
						    const fileName = event.target.files[0].name;
						    fileLabel.textContent = fileName;
					  	  	});
						</script>
					</div>
				</div>
			</div>
			<!-- Phần mô tả -->
			<div class="form-group">
				<label for="description">Mô tả chi tiết:</label>
				<textarea id="descriptionTextarea" class="form-control"
					name="description"></textarea>
				<script>
					  ClassicEditor
					    .create(document.querySelector('#descriptionTextarea'))
					    .catch(error => {
					      console.error(error);
		   			 });
				</script>
			</div>

			<!-- Phần nút  -->
			<div class="btn-toolbar justify-content-end"  style ="position: fixed; bottom: 20px; right: 50px">

				<!-- Thêm nút Close -->
				<a class="btn btn-secondary" onclick="window.parent.hidePopup()">Đóng</a>

				<c:url var="listLink" value="TourControllerServlet">
					<c:param name="command" value="LIST" />
				</c:url>
				
				<!-- Thêm  nút Submit -->
					<%
				 	if (Message == null) {
					%>
						<button type="submit" class="btn btn-success ml-1" id="updateBtn" >Thêm Tour</button>
					<%}else {%>
					<!-- tạo link gửi yêu cầu hiển thị danh sách  -->
					<c:url var="TOURS_MANAGEMENT" value="TourControllerServlet">
						<c:param name="command" value="TOURS_MANAGEMENT" />
					</c:url>
					<a class = "btn btn-primary ml-1" href="${TOURS_MANAGEMENT}" target="_parent" >Tải lại DS</a>
					<%} %>
			
			</div>
		</form>
	</div>
	
</body>
</html>