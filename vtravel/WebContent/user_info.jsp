<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Chỉnh sửa thông tin người dùng</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<!-- navbar -->
	<jsp:include page="navbar.jsp" />
	<div class="container mt-5">
		<div class="card mx-auto" style="max-width: 1200px;">
			<div class="card-header text-bg-info text-black">
				<h1 class="h3 mb-0">Thông tin người dùng</h1>
			</div>
			<div class="card-body">
				<form>
					<div class="form-group">
						<input type="hidden" id="editUserId" name="userId"
							class="form-control" value="${sessionScope.ID}"
							readonly="readonly" />
					</div>
					<div class="form-group">
						<label for="editFullname">Họ và tên:</label> <input type="text"
							id="editFullname" name="fullname" class="form-control"
							value="${sessionScope.fullname}" />
					</div>
					<div class="form-group">
						<label for="editUsername">Tên tài khoản:</label> <input
							type="text" id="editUsername" name="username"
							class="form-control" value="${sessionScope.username}" />
					</div>
					<div class="form-group">
						<label for="editEmail">Email:</label> <input type="text"
							id="editEmail" name="email" class="form-control"
							value="${sessionScope.email}" readonly="readonly" />
					</div>
					<div class="form-group">
						<label for="editPhoneNumber">Số điện thoại:</label> <input
							type="text" id="editPhoneNumber" name="phoneNumber"
							class="form-control" value="${sessionScope.phoneNumber}"
							readonly="readonly" />
					</div>
					<div class="form-group">
						<label for="editPassword">Mật khẩu:<span
							class="small text-muted" id="passwordHint"> (Mật khẩu phải
								có ít nhất 8 ký tự, bao gồm cả chữ cái và số)</span></label> <input
							type="password" id="editPassword" name="password"
							class="form-control" value="${sessionScope.password}" />
					</div>
					<div class="form-group">
						<input type="hidden" id="editRole" name="role"
							class="form-control" value="${sessionScope.role}" />
					</div>
					<div class="form-group">
						<input type="hidden" id="editStatus" name="status"
							class="form-control" value="${sessionScope.status}" />
					</div>
					<!-- Nút Lưu -->
					<button type="button" class="btn btn-secondary"
						onclick="submitForm()">Thay đổi thông tin</button>
				</form>
			</div>
		</div>
	</div>

	<script>
		function closePopup() {
			// Đóng pop-up
			window.parent.hidePopup();
		}
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
			var id = document.getElementById('editUserId').value;
			var username = document.getElementById('editUsername').value;
			var fullname = document.getElementById('editFullname').value;
			var email = document.getElementById('editEmail').value;
			var phone_number = document.getElementById('editPhoneNumber').value;
			var password = document.getElementById('editPassword').value;
			var role = document.getElementById('editRole').value;
			var status = document.getElementById('editStatus').value;
			var validPassword = checkPassword();

			if (!validPassword) {
				alert('Mật khẩu không đúng định dạng. Mật khẩu phải có ít nhất 8 ký tự, bao gồm cả chữ cái và số.');
				return;
			}

			// Kiểm tra nếu có bất kỳ ô nào trống thì hiển thị thông báo
			if (!username || !email || !fullname || !phone_number || !password
					|| !role) {
				alert('Vui lòng điền đầy đủ thông tin.');
				return;
			}

			// Gọi hàm savePost với các tham số đã lấy được
			saveUser(id, username, fullname, email, phone_number, password,
					role, status);

			// Ngăn form submit bằng cách trả về false
			return false;
		}

		function saveUser(id, username, fullname, email, phone_number,
				password, role, status) {
			// Gửi yêu cầu AJAX đến controller
			$.ajax({
				type : "POST",
				url : "user-management",
				data : {
					id : id,
					username : username,
					command : "CHANGE",
					fullname : fullname,
					email : email,
					phone_number : phone_number,
					password : password,
					status : status,
					role : role
				},
				success : function(data) {
					if (data == "success") {
						alert("Sửa thông tin thành công.");
					} else {
						alert("Sửa thông tin thất bại.");
					}
				},
				error : function() {
					alert("Lỗi khi gọi servlet ");
				}
			});
		}
	</script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
	<script
		src="https://cdn.ckeditor.com/ckeditor5/40.2.0/classic/ckeditor.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</body>
</html>
