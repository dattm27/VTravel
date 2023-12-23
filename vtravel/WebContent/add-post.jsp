<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Bài Viết Mới</title>   
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.ckeditor.com/ckeditor5/44.0.0/classic/ckeditor.js"></script>
</head>
<body>
	<!--Thêm navbar -->
	<jsp:include page="navbar.jsp" />
    <div class="container mt-4">
        <h3>Thêm Bài Viết Mới</h3>
        
        <!-- Form thêm bài viết -->
        <form id="addPostForm" enctype="multipart/form-data" onsubmit="return submitForm()">
            <div class="form-group">
                <label for="post_name">Tên Bài Viết:</label>
                <input type="text" class="form-control" id="post_name" name="post_name" required>
            </div>
            
            <div class="form-group">
                <label for="short_description">Tóm tắt:</label>
                <input type="text" class="form-control" id="short_description" name="short_description" required>
            </div>

            <!-- Ô tải lên ảnh -->
            <div class="form-group">
                <label for="image">Tải Lên Ảnh:</label>
                <input type="file" class="form-control-file" id="image" name="image">
            </div>

            <!-- Phần mô tả chi tiết -->
            <div class="form-group">
				<label for="content">Mô tả chi tiết:</label>
				<textarea id="contentTextarea" class="form-control"
					name="content"></textarea>
				<script>
					  ClassicEditor
					    .create(document.querySelector('#contentTextarea'))
					    .catch(error => {
					      console.error(error);
		   			 });
				</script>
			</div>

				<!-- Nút Lưu -->
			    <button type="submit" class="btn btn-primary" id="savePostBtn">Lưu</button>
			    <!-- Nút Hủy -->
			    <a class="btn btn-secondary" href="post-management?command=GET_ALL_POSTS">Hủy</a>
        </form>
    </div>

<script>
function submitForm() {
    // Lấy giá trị từ các trường dữ liệu của form
    var newImageInput = document.getElementById("image");

    // Kiểm tra xem đã chọn ảnh mới hay chưa
    if (!newImageInput || !newImageInput.files || newImageInput.files.length === 0) {
        alert("Bạn phải chọn ảnh trước.");
        return false;
    }
    // Lấy giá trị từ các trường dữ liệu của form
    var user_id = 1; // Đặt giá trị cho user_id tại đây
    var image = newImageInput.files[0].name;
    var content = document.getElementById("contentTextarea").value;
    var short_description = document.getElementById("short_description").value;
    var post_name = document.getElementById("post_name").value;

    // Gọi hàm savePost với các tham số đã lấy được
    savePost(user_id, image, content, short_description, post_name);

    // Ngăn form submit bằng cách trả về false
    return false;
}

function savePost(user_id, image, content, short_description, post_name) {
    // Gửi yêu cầu AJAX đến controller
    $.ajax({
        type: "POST",
        url: "add",
        data: { user_id: user_id,command: "add-post", image: image, content: content, short_description: short_description, post_name: post_name },
        success: function(data) {
            if (data == "success") { 
            	
                alert("Thêm bài viết thành công.");
                window.location.href = 'post-management?command=GET_ALL_POSTS';
            } else {
                alert("Thêm bài viết thất bại.");
            }
        },
        error: function() {
            alert("Lỗi khi gọi servlet add.");
        }
    });
}
</script>


</body>
</html>
