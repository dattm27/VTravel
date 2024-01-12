<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết thông tin người dùng</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.ckeditor.com/ckeditor5/44.0.0/classic/ckeditor.js"></script>
</head>
<body>
    <div class="container mt-5">
        <div class="p-4 bg-light">
            <h1 class="mb-4">Thông tin người dùng</h1>
            <form>
               	<div class="row">
               		<div class="col-md-6">            
		                <div class="form-group">
		                    <label for="editFullname">Fullname:</label>
		                    <input type="text" id="editFullname" name="fullname" class="form-control" />
		                </div>
	                </div>
	                <div class="col-md-6"> 
		                <div class="form-group">
		                    <label for="editEmail">Email:</label>
		                    <input type="text" id="editEmail" name="email" class="form-control" />
		                </div>
	                </div>
                </div>
		                
               	<div class="row">
               		<div class="col-md-6">
		                <div class="form-group">
		                    <label for="editUsername">Username:</label>
		                    <input type="text" id="editUsername" name="username" class="form-control" />
		                </div>
	                </div>
	                <div class="col-md-6">
		                <div class="form-group">
		                    <label for="editPhoneNumber">Số điện thoại:</label>
		                    <input type="text" id="editPhoneNumber" name="phoneNumber" class="form-control" />
		                </div>
	                </div>
                </div>

               	<div class="row">
               		<div class="col-md-6">		                
		                <div class="form-group">
		                    <label for="editPassword">Password:</label>
		                    <input type="password" id="editPassword" name="password" class="form-control" />
		                    <span class="small text-muted" id="passwordHint">
		                        (Mật khẩu phải có ít nhất 8 ký tự, bao gồm cả chữ cái và số)</span>
		                </div>
	                </div>
	                <div class="col-md-6">	
		                <div class="form-group">
		                    <label for="editRole">Vai trò:</label>
		                    <select id="editRole" name="role" class="form-control">
		                        <option value="admin">Admin</option>
		                        <option value="user">User</option>
		                    </select>
		                </div>
	                </div>
                </div>
                <div class="form-group">
                    <button type="button" class="btn btn-primary" onclick="submitForm()">Xác nhận</button>
                    <button type="button" class="btn btn-secondary" onclick="window.parent.hidePopup();">Hủy</button>
                </div>
            </form>
        </div>
    </div>

<script>
    function checkPassword() {
        var password = document.getElementById('editPassword').value;
        // Sử dụng biểu thức chính quy để kiểm tra mật khẩu
        var pattern = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;

        if (!pattern.test(password)) {
            document.getElementById('passwordHint').style.color = 'red';
            return false;
        } else {
            document.getElementById('passwordHint').style.color = '#777';
            return true;
        }
    }

   
    function submitForm() {
        var username = document.getElementById('editUsername').value;
        var fullname = document.getElementById('editFullname').value;
        var email = document.getElementById('editEmail').value;
        var phone_number = document.getElementById('editPhoneNumber').value;
        var password = document.getElementById('editPassword').value;
        var role = document.getElementById('editRole').value;
        var status = "active";
        var validPassword = checkPassword();

        if (!validPassword) {
            alert('Mật khẩu không đúng định dạng. Mật khẩu phải có ít nhất 8 ký tự, bao gồm cả chữ cái và số.');
            return;
        }

        // Kiểm tra nếu có bất kỳ ô nào trống thì hiển thị thông báo
        if (!username || !email || !fullname || !phone_number || !password || !role) {
            alert('Vui lòng điền đầy đủ thông tin.');
            return;
        }

        // Gọi hàm savePost với các tham số đã lấy được
        saveUser(username, fullname, email, phone_number, password,role,status);

        // Ngăn form submit bằng cách trả về false
        return false;
    }

    function saveUser(username, fullname, email, phone_number, password,role,status) {
        // Gửi yêu cầu AJAX đến controller
        $.ajax({
            type: "POST",
            url: "add",
            data: { username: username,command: "add-user", fullname: fullname,
            	email: email, phone_number: phone_number, password: password, status: status,role: role},
            success: function(data) {
                if (data == "success") {                     	
                    alert("Thêm tài khoản thành công.");
                    window.parent.location.href = 'user-management?command=LIST_ALL';
                    window.parent.hidePopup();
                } else {
                    alert("Thêm tài khoản thất bại.");
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
