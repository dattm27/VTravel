<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Đăng Kí</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container mt-4">
		 <c:url var="WELCOME" value="WelcomeControllerServlet">
		</c:url>
		 <h2> <a href="${WELCOME}">VTravel </a></h2>
		
	</div>
	<div class="container-fluid" >
    <div class="row d-flex justify-content-center align-items-center h-10">
      <div class="col-md-9 col-lg-6 col-xl-5">
        <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.webp"
          class="img-fluid" alt="Sample image">
      </div>
      <div class="col-md-8 col-lg-8 col-xl-4 offset-xl-1">
        <!-- dang ki thanh cong -->
						<%
						int SuccessfullRegister = (int) request.getAttribute("SuccessfullRegister");			
								if (SuccessfullRegister != 0) {
						%>
						<p class="input-group-text" style="color: red;"> <b>Chúc mừng! Bạn đã đăng kí thành công! </b></p> 
						<p class="input-group-text" style="color: red;"><b> Quay lại trang <a href="/vtravel/login.jsp"> đăng nhập</a> đã tiếp tục </b> </p>
						<%}%>
		<!-- ---------------------------------------------------- -->
        <form  method="POST" id="RegisterForm">
          <input type = "hidden" name = "command" value = "">
          <!-- Fullname input -->
          <div class="form-outline mb-3">
            <div class="mb-3">
                <label for="username" class="form-label">Họ và tên:</label>
                <input type="text" class="form-control" id="fullname" name="fullname" required = "required"
                placeholder="Nhập họ và tên" value= "${fullname}">
            </div>
          </div>
           <!-- Email input -->
          <div class="form-outline mb-3">
            	<label for="password" class="form-label">Email:</label>
                <input type="email" class="form-control" id="email" name="email" required = "required"
                placeholder="Nhập email" value="${email}">
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
          <!-- Username input -->
          <div class="form-outline mb-3">
            	<label for="password" class="form-label">Tên đăng nhập:</label>
                <input type="text" class="form-control" id="username" name="username" required = "required"
                placeholder="Nhập tên đăng nhập" value="${username}">
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
          <!-- Password input -->
          <div class="form-outline mb-3">
            	<label for="password" class="form-label">Mật khẩu:</label>
                <input type="password" class="form-control" id="password" name="password" required = "required"
                placeholder="Nhập mật khẩu" value="${password}" pattern="(?=.*\d)(?=.*[a-zA-Z]).{8,}">
                 <small>Mật khẩu tối thiểu 8 ký tự, bao gồm cả chữ cái và số</small>
          </div>
          
			<!-- kiem tra format cua mat khau -->
			<%
			int validFormatPassword = (int) request.getAttribute("validFormatPassword");			
					if (validFormatPassword != 0) {
			%>
				<p class="input-group-text" style="color: red;"> <b>(*)Mật khẩu phải có ít nhất 8 ký tự, bao gồm cả chữ cái và số</b></p>		
			<%
			}
			%>
          <!-- Check Password input -->
          <div class="form-outline mb-3">
            	<label for="password" class="form-label"> Xác nhận mật khẩu:</label>
                <input type="password" class="form-control" id="re_password" name="re_password" required = "required"
                placeholder="Nhập lại mật khẩu">
                 <small id="passwordMismatchError" class="error mt-1 text-danger" style="display: none;">Hai mật khẩu chưa trùng khớp</small>
          </div>
        
          <!-- kiem tra xac nhan mat khau -->
			<%
			int validPassword = (int) request.getAttribute("validPassword");			
					if (validPassword != 0) {
			%>
				<p class="input-group-text" style="color: red;"> <b>(*)Mật khẩu nhập lại không trùng khớp</b></p>		
			<%
			}
			%>
		<!-- ---------------------------------------------------- -->
           <!-- Phonenumber input -->
          <div class="form-outline mb-3">
            	<label for="password" class="form-label"> Số điện thoại:</label>
                <input type="text" class="form-control" id="phone_number" name="phone_number" required = "required"  pattern="0[0-9]{9}" 
                placeholder="Điền số điện thoại" value="${phone_number}">
                <small>Số điện thoại phải có 10 chữ số</small>
          </div>
          <!-- kiem tra sdt -->
			<%
			int validPhone_number = (int) request.getAttribute("validPhone_number");			
					if(validPhone_number > 0) {
						%>
						<p class="input-group-text" style="color: red;"> <b>(*)Số điện thoại đã có người sử dụng </b> </p>
						<%
					}
						
			%>
		<!-- ---------------------------------------------------- -->
         <!--  <div class="text-center text-lg-start mt-2 pt-2">
            <button type="submit" class="btn btn-primary btn-lg"
              style="padding-left: 2.5rem; padding-right: 2.5rem;">Đăng kí</button>
              <p class="text-center text-muted"> Khi bạn ấn Đăng Kí, đồng nghĩa với việc bạn chấp nhận         
							<a href="#">điều khoản dịch vụ</a> của chúng tôi </p>
          </div> -->
          <div class="text-center text-lg-start mt-4 pt-2">
            <button type="submit" class="btn btn-primary btn-lg"
              style="padding-left: 2.5rem; padding-right: 2.5rem;">Đăng ký</button>
            <p class="small fw-bold mt-2 pt-1 mb-0"> Khi bạn ấn Đăng Ký, đồng nghĩa với việc bạn chấp nhận  <a href="#"
                class="link-danger">điều khoản dịch vụ</a> của chúng tôi</p>
          </div>

        </form>
      </div>
    </div>
  </div>
  	<script>
				var passwordInput = document.getElementById("password");
				var passwordCheckInput = document
						.getElementById("re_password");
				var errorDiv = document.getElementById("passwordMismatchError");

				 /* kiểm tra hai mật khẩu chưa trùng khớp */ 
				passwordCheckInput.addEventListener("input", function() {
					if (passwordInput.value !== passwordCheckInput.value) {
						errorDiv.style.display = "block";
					} else {
						errorDiv.style.display = "none";
					}
				});
				
				/* mật khẩu phải từ 8 ký tự, có cả chữ cái và số */
				var passwordRequirementsErrorDiv = document.getElementById("passwordRequirementsError");

			    passwordInput.addEventListener("input", function() {
			        if (!passwordInput.checkValidity()) {
			            passwordRequirementsErrorDiv.style.display = "block";
			        } else {
			            passwordRequirementsErrorDiv.style.display = "none";
			        }
			    });
			</script>
</body>
</html>