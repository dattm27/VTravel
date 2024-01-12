<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Quản lý tài khoản </title>
	<!-- Thư viện CSS Bootstrap -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<!-- Thêm script của Bootstrap Modal -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.2/js/bootstrap.bundle.min.js"></script>
	<!-- script hiển thị pop up -->
	 <script src="js/pop-up.js"></script>  
	 <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	 
  	<link rel="stylesheet" href="css/pop-up.css"> 
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
  	
   <!-- script phân trang, tìm kiếm -->
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
		<h3>Danh sách tài khoản</h3>
		<!-- tạo link gửi yêu cầu hiển thị danh sách  -->
		<c:url var="LIST_ALL" value="user-management">
			<c:param name="command" value="LIST_ALL" />
		</c:url>
		<c:url var="ADD_USER" value ="user-management">
		 				<c:param name="command" value="ADD"/>				 				
		</c:url>
		<div class="mb-3">
			<a href="${LIST_ALL}" class="btn btn-info mr-2">Tải DS tài khoản</a>
			<button class="btn btn-primary" onclick = "showPopup('${ADD_USER}')">Thêm tài khoản mới</button>
		</div>
		<!-- Phần phân trang và tìm kiếm -->
		<div class="row">
		    <!-- Chọn số bản ghi mỗi trang -->
		    <div class="input-group col-md-4 mb-3 ">
			    <div class="input-group-prepend">
			        <label for="recordsPerPage" class="input-group-text">Số bản ghi/trang:</label>
			        <select class="custom-select" id="recordsPerPage" onchange="changeRecordsPerPage()">
			            <option value="all">Hiển thị tất cả</option>
			            <option value="5">5</option>
			            <option value="10" selected>10</option>
			            <option value="20">20</option>
			        </select>
			    </div>
			  </div>
			
		<div class="input-group col-md-3 mb-3  ">
			  <div class="input-group-prepend">
			    <label class="input-group-text" for="Filter">Lọc</label>
			  </div>
			  <select class="custom-select" id="Filter" onchange="filterByStatus()">
			    <option selected value="Chọn trạng thái" disabled>Chọn vai trò</option>
			    <option value="admin">ADMIN</option>
			    <option value="user">USER</option>
			    <option value ="Chọn trạng thái">Tất cả </option>
			  </select>
		</div>
			
		    <div class="input-group mb-3 col-md-4 ml-auto " >
			  <div class="input-group-prepend">
			    <span class="input-group-text" >Tìm kiếm</span>
			  </div>
			  <input type="text" class="form-control" id="searchInput" name="search" placeholder="VD: Tên, gmail"   oninput="searchData('data-search-1','data-search-2')">
			</div>
			
		</div>

		<table class="table" id="table-body">
		   <thead>
		       <tr>
		           <th>ID</th>
		           <th>Email</th>
		           <th>Tên người dùng</th>
		           <th>Số điện thoại</th>
		           <th>Trạng thái</th>
		           <th>Vai trò</th>
		           <th>Chi tiết</th>
		           <th>Hành động</th>
		       </tr>
		   </thead>
		   <tbody id="InfoBody">
		       <c:forEach var="account" items="${accountList}">
		           <tr id="account-row-${account.id}" class="row-item" data-search-1="${account.fullname}" data-search-2="${account.email}" status="${account.status}">
		               <td>${account.id}</td>
		               <td>${account.email}</td>
		               <td>${account.fullname}</td>
		               <td>${account.phone_number}</td>
		               <td id="lock-${account.id}">${account.status}</td>
		               <td id="status_${account.role}">${account.role}</td>
		               <td>
		               	<c:url var="DETAIL_USER" value ="user-management">
			 				<c:param name="command" value="DETAIL"/>
			 				<c:param name="userId" value="${account.id}"/>				 				
			 			</c:url>
		                   <button class="btn btn-link text-info p-0" onclick="showPopup('${DETAIL_USER}')">
		                       Mô tả chi tiết
		                   </button>
		               </td>
		               <td>
		               <c:url var="UPDATE_USER" value ="user-management">
			 				<c:param name="command" value="LOAD"/>
			 				<c:param name="userId" value="${account.id}"/>				 				
		 			</c:url>
		      				<button class="btn btn-warning" onclick="showPopup('${UPDATE_USER}')">Sửa</button>		                
		                <button class="btn btn-warning" onclick="lockAccount(${account.id})">Mở/khóa</button>
		                <button class="btn btn-secondary" onclick="deleteAccount(${account.id})">Xóa</button>
		            </td>
		           </tr>
		       </c:forEach>
		   </tbody>
		</table>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
		
		<!-- Nút phân trang -->
		 <div id="pagination">
		    <button onclick="previousPage()" class="btn btn-sm btn-outline-primary">Previous Page</button>
		    <span id="currentPage">1</span>
		    <button onclick="nextPage()" class="btn btn-sm btn-outline-primary">Next Page</button>
		</div> 
		
		<!-- Truyền giá trị PROPOSAL_LIST.size() vào một thuộc tính HTML -->
		<div id="proposalListSize" data-size="${accountList.size()}"></div>
		
		<!-- Javascript xử lý phân trang và tìm kiếm -->
		 <script src="js/pagination_and_search.js"></script>  
	</div>
</body>
<script>
    function lockAccount(userId) {
        $.ajax({
            type: "POST",
            url: "lock",
            data: { userId: userId },
            success: function(data) {
                if (data === "success") {
                    // Tìm phần tử trạng thái dựa trên userId và cập nhật nó
                    var statusElement = $("#lock-" + userId);

                    if (statusElement.length) {
                        var currentStatus = statusElement.text();
                        if(currentStatus === "disabled"){
                        	var newStatus = "active";
                        	alert("Mở thành công.");
                        }else{
                        	var newStatus = "disabled";
                        	alert("Khóa thành công.");
                        }
                        statusElement.text(newStatus);
                    }
                } else {
                    alert("Không thể thực hiện hành động lock.");
                }
            },
            error: function() {
                alert("Lỗi khi gọi servlet lock.");
            }
        });
    }

    function deleteAccount(userId) {
        $.ajax({
            type: "POST",
            url: "delete",
            data: { userId: userId },
            success: function(data) {
                if (data === "success") {
                    // Tìm phần tử tài khoản dựa trên userId và ẩn nó
                    var accountElement = $("#account-row-" + userId);

                    if (accountElement.length) {
                        accountElement.hide(); // Ẩn phần tử tài khoản
                        alert("Xóa thành công.");
                    } else {
                        alert("Không tìm thấy phần tử tài khoản để ẩn.");
                    }
                } else {
                    alert("Không thể thực hiện hành động xóa.");
                }
            },
            error: function() {
                alert("Lỗi khi gọi servlet delete.");
            }
        });
    }
</script>
</html>