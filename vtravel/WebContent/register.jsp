<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Đăng kí</title>
	<link rel="stylesheet" href="css_of_Son/bootstrap.min.css">
	<link rel="stylesheet" href="css_of_Son/all.min.css">
	<link rel="stylesheet" href="css_of_Son/style.css">
	
</head>
<body class="bg-light">
	<div class="container">
		<div class="row mt-5">
			<div class="col-lg-4 bg-white m-auto rounded-top wrapper">
				<h2 class="text-center pt3">Đăng kí tài khoản</h2>
				<p class="text-center text-muted lead">Chào mừng đến với Vtravel</p>
				<!-- dang ki thanh cong -->
						<%
						int SuccessfullRegister = (int) request.getAttribute("SuccessfullRegister");			
								if (SuccessfullRegister != 0) {
						%>
						<p class="input-group-text" style="color: red;"> <b>(*)Chúc mừng! Bạn đã đăng kí thành công! </b></p> 
						<p class="input-group-text" style="color: red;"><b> Quay lại trang <a href="/vtravel/login.jsp"> đăng nhập</a> đã tiếp tục </b> </p>
						<%
						}
						%>
				<!-- ---------------------------------------------------- -->
				<!-- Form start -->
				<form action="#" method="post">
					<div class="input-group mb-3">
						<span class="input-group-text"><i class="fa fa-user"></i></span>
						<input type="text" class="form-control" placeholder="Họ và tên" name="fullname" required = "required"/> 
					</div>
					<div class="input-group mb-3">
						<span class="input-group-text"><i class="fa fa-user"></i></span>
						<input type="text" class="form-control" placeholder="Tên đăng nhập" name="username" required = "required"/> 
					</div>
					<!-- kiem tra ten dang nhap -->
						<%
						int validUserName = (int) request.getAttribute("validUsername");			
								if (validUserName != 0) {
						%>
						<p class="input-group-text" style="color: red;"> <b>(*)Tên đăng nhập đã có người sử dụng </b> </p>
						<%
						}
						%>
					<!-- ---------------------------------------------------- -->
					<div class="input-group mb-3">
						<span class="input-group-text"><i class="fa fa-envelope"></i></span>
						<input type="email" class="form-control" placeholder="Email" name="email" required = "required"/> 
					</div>
					<!-- kiem tra email -->
						<%
						int validEmail = (int) request.getAttribute("validEmail");			
								if (validEmail != 0) {
						%>
						<p class="input-group-text" style="color: red;"> <b>(*)Email đã có người sử dụng </b> </p>
						<%
						}
						%>
					<!-- ---------------------------------------------------- -->
					<div class="input-group mb-3">
						<span class="input-group-text"><i class="fa fa-phone"></i></span>
						<input type="text" class="form-control" placeholder="Điện thoại" name="phone_number" required = "required"/> 
					</div>
					<!-- kiem tra sdt -->
						<%
						int validPhone_number = (int) request.getAttribute("validPhone_number");			
								if (validPhone_number == -1) {
						%>
						<p class="input-group-text" style="color: red;"> <b>(*)Số điện thoại phải có 10 số </b> </p>
						<%
						}
								if(validPhone_number > 0) {
									%>
									<p class="input-group-text" style="color: red;"> <b>(*)Số điện thoại đã có người sử dụng </b> </p>
									<%
								}
									
						%>
					<!-- ---------------------------------------------------- -->
					<div class="input-group mb-3">
						<span class="input-group-text"><i class="fa fa-lock"></i></span>
						<input type="password" class="form-control" placeholder="Mật khẩu" name="password" required = "required"/> 
					</div>
					<div class="input-group mb-3">
						<span class="input-group-text"><i class="fa fa-lock"></i></span>
						<input type="password" class="form-control" placeholder="Xác nhận mật khẩu" name="re_password" required = "required"/> 
					</div>
					<!-- kiem tra mat khau -->
						<%
						int validPassword = (int) request.getAttribute("validPassword");			
								if (validPassword != 0) {
						%>
						<p class="input-group-text" style="color: red;"> <b>(*)Nhập lại mật khẩu không trùng khớp </b> </p>
						<%
						}
						%>
					<!-- ---------------------------------------------------- -->
					<div class="d-grid">
						<button type="submit" class="btn btn-success">Đăng kí</button>
						<p class="text-center text-muted"> Khi bạn ấn Đăng Kí, đồng nghĩa với việc bạn chấp nhận         
							<a href="youtube.com">điều khoản dịch vụ</a> của chúng tôi </p>
					</div>
					
					<p class="text-center">
						Đã có tài khoản, <a href="/vtravel/login.jsp">đăng nhập</a> ngay
					</p>
				</form>	
			</div>
		</div>
	</div>
	
	
	<script src="js_of_Son/bootstrap.bundle.min.js"></script>
</body>
</html>