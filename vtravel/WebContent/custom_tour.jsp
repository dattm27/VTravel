<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
<title>VTravel - Tuỳ chọn chuyến đi</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<!-- Thêm script của Bootstrap Modal -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.2/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<!-- Phần nav-bar -->
	<jsp:include page="navbar.jsp" />
	<!-- Hết phần navbar -->
	
	<!-- Phần thân trang -->
	<div class="container-fluid">
	  <div class="row">
	    <!-- Phần bên trái với hình ảnh minh hoạ -->
	    <div class="col-md-5">
	      <img src="images/bg2.jpeg" alt="Hình ảnh minh hoạ" class="img-fluid" style="width:100%; object-fit: cover;">
	    </div>
	
	    <!-- Phần bên phải với form nhập thông tin -->
	    <div class="col-md-7">
	      <h3 class="mt-3" >Nhập thông tin chuyến đi của bạn</h3>
	      <form action="TourControllerServlet" method ="POST" >
	       	<input type="hidden" name="command" value="REQUEST_CUSTOM_TOUR">
	       	<input type="hidden" name= "userID" value="1"/>
	        
	        <div class="form-group">
			    <label for="destination">Địa điểm:</label>
			    <select class="form-control" id="destinationSelect" name="destination" required onchange="checkOtherOption()">
			        <!-- Add your list of places as options -->
			        <option value="Nha Trang">Nha Trang</option>
			        <option value="Hồ Chí Minh">Hồ Chí Minh</option>
			        <option value="Quảng Ninh">Quảng Ninh</option>
			        <option value="Hà Nội">Hà Nội</option>
			        <option value="other">Khác</option>
			        <!-- Add more options as needed -->
			    </select>
			</div>
			<!--Nhập địa điểm khác -->
	        <div class="form-group" id="otherDestinationGroup" style="display: none;">
	          <label for="otherDestination">Địa điểm khác:</label>
	          <input type="text" class="form-control" id="otherDestination" name="otherDestination" placeholder="VD: Nha Trang"   >
	        </div> 
	        
	        <!-- script xử lý ẩn hiện input địa điểm khác -->
	        <script>
			    function checkOtherOption() {
			        var selectBox = document.getElementById("destinationSelect");
			        var otherDestinationGroup = document.getElementById("otherDestinationGroup");
			
			        if (selectBox.value === "other") {
			            otherDestinationGroup.style.display = "block";
			        } else {
			            otherDestinationGroup.style.display = "none";
			        }
			    }
			</script>
	        
	         <!-- Phần chọn ngày bắt đầu, kết thúc và xử lý ngày hợp lệ -->
	         <div class="form-group">
	            <label for="start_date">Ngày bắt đầu:</label>
	            <input type="date" class="form-control" id="start_date" name="start_date"  
	              title="Ngày bắt đầu sau hiện tại tối thiểu 1 tuần" required >
	              <small class="form-text text-muted">Nhập ngày bắt đầu trước ngày đặt tối thiểu 7 ngày</small>
	              <!-- chỉ cho phép chọn ngày sau ngày hiện tại 7 ngày -->
	              <script>
		              var currentDate = new Date();
		              currentDate.setDate(currentDate.getDate() + 7); // Thêm 7 ngày
		              var minDate = currentDate.toISOString().split("T")[0];
		              document.getElementById("start_date").setAttribute("min", minDate);
				</script>
          	</div>
          	<div class="form-group" >
	            <label for="end_date">Ngày kết thúc:</label>
	            <input type="date" class="form-control" id="end_date" name="end_date"  
	              title="Chọn ngày kết thúc sau ngày bắt đầu" required disabled>
	            <small class="form-text text-muted">Nhập ngày bắt đầu trước khi nhập ngày kết thúc</small>
	           <!-- chỉ cho phép chọn sau khi chọn ngày bắt đầu, ngày kết thúc phải sau ngày bắt đầu -->
		        <script>
				    var startDateInput = document.getElementById("start_date");
				    var endDateInput = document.getElementById("end_date");
				
				    startDateInput.addEventListener("change", function() {
				        var startDate = new Date(startDateInput.value);
				        var endDate = new Date(endDateInput.value);
				
				        if (endDate && endDate <= startDate) {
				            endDateInput.value = "";
				        }
				
				        endDateInput.min = startDateInput.value;
				        endDateInput.disabled = false;
				    });
				</script>
          	</div>
	        <div class="form-group">
	                <label for="number_of_travaller" style="font-size:17px">Số lượng người</label>
	                <input type="number" class="form-control" id="number_of_traveller" name="number_of_traveller" required min = "1"
	                title = "Số lượng du khách tối thiểu là 1">
		     </div>
			<div class="form-group">
				<label for="note">Mô tả:</label>
				<textarea class="form-control" id="note" rows="4"
					placeholder="Nhập nội dung" name="note"></textarea>
			</div>
			<div class="form-check form-group">
				<input class="form-check-input" type="checkbox" value=""
					id="agree" required> <label class="form-check-label"
					for="agree" > Tôi đồng ý với các điều khoản và chính sách </label>
			
			</div>
			<button type="submit" class="btn btn-primary">Gửi</button>
	      </form>
	    </div>
	  </div>
	</div>
	
</body>
</html>