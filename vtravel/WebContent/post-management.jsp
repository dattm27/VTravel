<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý bài viết</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.2/js/bootstrap.bundle.min.js"></script>
    <script src="js/post-management-popup.js"></script>
    <link rel="stylesheet" href="css/post-management-popup.css">
    <script src="https://cdn.ckeditor.com/ckeditor5/31.1.0/classic/ckeditor.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <script src="js/custom_tour_management.js"></script>
   
</head>
<body>
	<!--Thêm navbar -->
	<jsp:include page="navbar.jsp" />
    <div class="ml-5 mr-5">
        <a href="home.jsp" class="btn btn-primary mb-2">Trang chủ</a>
        <h3>Danh sách bài viết</h3>

        <div class="mb-3">
            <button class="btn btn-info mr-2" onclick = "loadPosts()">Tải DS bài viết</button>
            <button class="btn btn-primary" onclick = "addPost()">Thêm bài viết mới</button>
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
			
			
		    <div class="input-group mb-3 col-md-4 ml-auto " >
			  <div class="input-group-prepend">
			    <span class="input-group-text" >Tìm kiếm</span>
			  </div>
			  <input type="text" class="form-control" id="searchInput" name="search" placeholder="VD: Nha Trang"   oninput="searchData('data-search-1','data-search-2')">
			</div>
			
		</div>


<!-- ... Các phần khác ... -->

		<table class="table" id ="table-body">
		    <thead>
		        <tr>
		            <th>ID</th>
		            <th>Người đăng</th>
		            <th>Tên bài viết</th>
		            <th>Hình ảnh</th>
		            <th>Chi tiết</th>
		            <th>Ngày đăng</th>
		            <th>Hành động</th>
		        </tr>
		    </thead>
		    <tbody id="InfoBody">
		        <c:forEach var="post" items="${postList}">
		            <tr id="post-row-${post.id}" class="row-item" data-search-1="${post.fullname}" data-search-2="${post.post_name}">
		                <td>${post.id}</td>
		                <td>${post.fullname}</td>
		                <td>${post.post_name}</td>
		                <td>
                    		<img src="images/post/${post.image}" alt="Hình ảnh" style="max-width: 100px; max-height: 100px;">
                		</td>
		                <td>
		                	<c:url var="DETAIL_POST" value ="post-management">
				 				<c:param name="command" value="GET_POST_CONTENT"/>
				 				<c:param name="postId" value="${post.id}"/>				 				
				 			</c:url>
		                    <button class="btn btn-link text-info p-0" onclick="showPopup('${DETAIL_POST}')">
		                        Mô tả chi tiết
		                    </button>
		                </td>
		                <td>${post.post_date}</td>
		                <td>
		                    <button class="btn btn-warning" onclick="editPost(${post.id})">Sửa</button>
		                    <button class="btn btn-secondary" onclick="deletePost(${post.id})">Xóa</button>
		                </td>
		            </tr>
		        </c:forEach>
		    </tbody>
		</table>
		
		
		<!-- Phần pop-up -->
		<div id="popup" class="popup" style="display: none">
		    <div class="iframe-container">
		        <!-- nút đóng -->
		        <button type="button" class="btn btn-primary btn-circle close-icon" data-dismiss="modal" onclick="hidePopup()">
		            <i class="fas fa-times"></i>
		        </button>
		        <!-- iframe để hiển thị trang khác trong pop up -->
		        <iframe id="popup-iframe" src="" width="100%" height="650px"></iframe>
		    </div>
		</div>
		
		
		
		<!-- Nút phân trang -->
		 <div id="pagination">
		    <button onclick="previousPage()" class="btn btn-sm btn-outline-primary">Previous Page</button>
		    <span id="currentPage">1</span>
		    <button onclick="nextPage()" class="btn btn-sm btn-outline-primary">Next Page</button>
		</div> 
		
		<!-- Truyền giá trị PROPOSAL_LIST.size() vào một thuộc tính HTML -->
		<div id="proposalListSize" data-size="${postList.size()}"></div>
		<script src="js/post_search.js"></script>

<!-- ... Các phần khác ... -->

    </div>
</body>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>

    function loadPosts() {
    	window.location.href = 'post-management?command=GET_ALL_POSTS';
    }
    function addPost() {
    	window.location.href = 'post-management?command=ADD&user_id=1';
    }
    function editPost(id) {
        window.location.href = 'post-management?command=EDIT&id=' + id;
    }
    function deletePost(id) {
        $.ajax({
            type: "POST",
            url: "delete",
            data: { id: id },
            success: function(data) {
                if (data === "success") {
                    // Tìm phần tử tài khoản dựa trên userId và ẩn nó
                    var accountElement = $("#post-row-" + id);

                    if (accountElement.length) {
                    	alert("Xóa thành công.");
                        accountElement.hide(); // Ẩn phần tử tài khoản
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
