<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh Sửa Bài Viết</title>   
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdn.ckeditor.com/ckeditor5/31.1.0/classic/ckeditor.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<!--Thêm navbar -->

    <div class="container mt-4">
         <%
		String Message = (String) request.getAttribute("message");
	 	
	 	if (Message != null) {
			
		%>
			<h3 class= "text-success">Chỉnh sửa bài viết thành công</h3>
				<!-- tạo link gửi yêu cầu hiển thị danh sách  -->
			<c:url var="TOURS_MANAGEMENT" value="post-management"> </c:url>
		<form id="editPostForm" enctype="multipart/form-data">
			<!-- Thêm thẻ input hidden để lưu trữ tên file ảnh hiện tại -->
			<input type="hidden" id="editCurrentImage" name="currentImage" value="${postUP.image}">
			
            <div class="form-group">
                <label for="editPostName">Tên Bài Viết:</label>
                <input type="text" class="form-control" id="editPostName" name="post_name" value="${postUP.post_name}" readonly="readonly">
            </div>
            
            <div class="form-group">
                <label for="editShortDescription">Tóm tắt:</label>
                <input type="text" class="form-control" id="editShortDescription" name="short_description" value="${postUP.short_description}" readonly="readonly">
            </div>

			<div class="form-group">
				<label for="imageUpload" id="imageUpload">Tải lên ảnh:</label>
				<div class="custom-file">
					<input type="hidden" name = "oldImage" id = "oldImage" value= "${postUP.image}"/>
					<input type="file" class="custom-file-input" id="image"
						name="image" readonly="readonly"> <label class="custom-file-label"
						for="image" id="fileUpload">${postUP.image.substring(postUP.image.indexOf('_') + 1, postUP.image.indexOf('_') + 1 + Math.min(30, postUP.image.length() - postUP.image.indexOf('_') - 1))}</label>
				</div>
			</div>

            <!-- Phần mô tả chi tiết -->
            <div class="form-group">
                <label for="editContent">Mô tả chi tiết:</label>
                <textarea id="editContentTextarea" class="form-control" readonly="readonly" name="content">${postUP.content}</textarea>
                <script>
                    ClassicEditor
                        .create(document.querySelector('#editContentTextarea'))
                        .catch(error => {
                            console.error(error);
                        });
                </script>
            </div>
        </form>
		<a class = "btn btn-primary ml-1" href="${TOURS_MANAGEMENT}" target="_parent" >Tải lại DS</a>
		<%} 
	 	
	 	else {%>
        <h3 class= "text-success">Chỉnh sửa thông tin bài viết</h3>
        <!-- Form chỉnh sửa bài viết -->
        <form id="editPostForm" action="post-management" method="POST" id="updateForm" enctype="multipart/form-data">
        	<input type="hidden" name="command" value="UPDATE">
			<input type="hidden" name="id" value = "${post.id}">
			<!-- Thêm thẻ input hidden để lưu trữ tên file ảnh hiện tại -->
			<input type="hidden" id="editCurrentImage" name="currentImage" value="${post.image}">
			
            <div class="form-group">
                <label for="editPostName">Tên Bài Viết:</label>
                <input type="text" class="form-control" id="editPostName" name="post_name" value="${post.post_name}" required>
            </div>
            
            <div class="form-group">
                <label for="editShortDescription">Tóm tắt:</label>
                <input type="text" class="form-control" id="editShortDescription" name="short_description" value="${post.short_description}" required>
            </div>

			<div class="form-group">
				<label for="imageUpload" id="imageUpload">Tải lên ảnh:</label>
				<div class="custom-file">
					<input type="hidden" name = "oldImage" id = "oldImage" value= "${post.image}"/>
					<input type="file" class="custom-file-input" id="image"
						name="image"> <label class="custom-file-label"
						for="image" id="fileUpload">${post.image.substring(post.image.indexOf('_') + 1, post.image.indexOf('_') + 1 + Math.min(30, post.image.length() - post.image.indexOf('_') - 1))}</label>
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


            <!-- Nút Lưu -->
            <button type="submit" class="btn btn-success ml-1" id="updateBtn" >Cập nhật</button>
            <!-- Nút Hủy -->
            <a class="btn btn-secondary" href="post-management?command=GET_ALL_POSTS">Hủy</a>
        </form>
        <%} %>
    </div>
	


</body>
</html>
