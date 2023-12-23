<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh Sửa Bài Viết</title>   
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://cdn.ckeditor.com/ckeditor5/31.1.0/classic/ckeditor.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<!--Thêm navbar -->
	<jsp:include page="navbar.jsp" />
    <div class="container mt-4">
        <h3>Chỉnh Sửa Thông Tin Bài Viết</h3>
        
        <!-- Form chỉnh sửa bài viết -->
        <form id="editPostForm" enctype="multipart/form-data" >
        	<!-- Thêm thẻ input hidden để lưu trữ tên file ảnh hiện tại -->
			<input type="hidden" id="editCurrentImage" name="currentImage" value="${post.image}">
			
            <div class="form-group">
                <label for="editPostName">Tên Bài Viết:</label>
                <input type="text" class="form-control" id="editPostName" name="postName" value="${post.post_name}" required>
            </div>
            
            <div class="form-group">
                <label for="editShortDescription">Tóm tắt:</label>
                <input type="text" class="form-control" id="editShortDescription" name="shortDescription" value="${post.short_description}" required>
            </div>

            <!-- Hiển thị ảnh hiện tại -->
            <div class="form-group">
                <label for="editCurrentImage">Ảnh hiện tại:</label>
                <img src="images/post/${post.image}" class="img-thumbnail" alt="Hình ảnh">
            </div>

            <!-- Ô tải lên ảnh mới -->
            <div class="form-group">
                <label for="editNewImage">Chọn ảnh mới:</label>
                <input type="file" class="form-control-file" id="editNewImage" name="newImage">
            </div>

            <!-- Phần mô tả chi tiết -->
            <div class="form-group">
                <label for="editContent">Mô tả chi tiết:</label>
                <textarea id="editContentTextarea" class="form-control" name="content">${post.content}</textarea>
                <script>
                    ClassicEditor
                        .create(document.querySelector('#editContentTextarea'))
                        .catch(error => {
                            console.error(error);
                        });
                </script>
            </div>

            <!-- Ẩn ô nhập ID và giữ nguyên giá trị -->
            <div class="form-group">
                <label for="editPostId">ID Bài Viết:</label>
                <input type="text" class="form-control" id="editPostId" name="postId" value="${post.id}" readonly="readonly">
            </div>

            <!-- Nút Lưu -->
            <button type="button" class="btn btn-primary" onclick = "submitForm(${post.id})" >Lưu</button>
            <!-- Nút Hủy -->
            <a class="btn btn-secondary" href="post-management?command=GET_ALL_POSTS">Hủy</a>
        </form>
    </div>


<script>
function submitForm(id) {
    // Lấy giá trị từ các trường dữ liệu của form
    var newImageInput = document.getElementById("editNewImage");

    // Kiểm tra xem đã chọn ảnh mới hay chưa
    if (!newImageInput || !newImageInput.files || newImageInput.files.length === 0) {
        alert("Bạn phải chọn ảnh mới.");
        return false;
    }

    var newImage = newImageInput.files[0].name;
    var content = document.getElementById("editContentTextarea").value;
    var short_description = document.getElementById("editShortDescription").value;
    var post_name = document.getElementById("editPostName").value;
    var curImage = document.getElementById("editCurrentImage").value;
    

    // Gọi hàm savePost với các tham số đã lấy được
    updatePost(id, newImage, content, short_description, post_name);

    // Ngăn form submit bằng cách trả về false
    return false;
}

function updatePost(id, image, content, short_description, post_name) {
    // Gửi yêu cầu AJAX đến controller
    $.ajax({
        type: "POST",
        url: "post-management",
        data: { id:id,command: "UPDATE",image: image, content: content, short_description: short_description, post_name: post_name },
        success: function(data) {
            if (data === "success") { 
            	
                alert("Sửa bài viết thành công.");
                window.location.href = 'post-management?command=GET_ALL_POSTS';
            } else {
                alert("Sửa bài viết thất bại.");
            }
        },
        error: function() {
            alert("Lỗi khi gọi servlet .");
        }
    });
}
</script>

</body>
</html>
