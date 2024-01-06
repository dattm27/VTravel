<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Đăng nhập</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	 <script src="js/pop-up.js"></script> 
</head>
<body>
	<div class="container mt-4">
		 <h2> <a href="index.jsp">VTravel </a></h2>
		
	</div>
	<div class="container-fluid h-custom" style = "margin-top: 20vh">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-md-9 col-lg-6 col-xl-5">
        <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.webp"
          class="img-fluid" alt="Sample image">
      </div>
      <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
        <form  action="SessionControllerServlet" method="POST" id="loginForm">
          <input type = "hidden" name = "command" value = "LOG_IN">
          <!-- Email input -->
          <div class="form-outline mb-4">
            <div class="mb-3">
                <label for="username" class="form-label">Tên đăng nhập:</label>
                <input type="text" class="form-control" id="username" name="username" required value="${param.username}"
                placeholder="Nhập tài khoản của bạn">
            </div>
          </div>

          <!-- Password input -->
          <div class="form-outline mb-3">
            	<label for="password" class="form-label">Mật khẩu:</label>
                <input type="password" class="form-control" id="password" name="password" required value = "${param.password}"
                placeholder="Nhập mật khẩu">
          </div>
          <%
			String logInMessage = (String) request.getAttribute("logInMessage");
				String username = (String) request.getAttribute("username");

				if (logInMessage != null) {
					if (logInMessage.equals("fail")) {
			%>
			<div class="message ">
				<div id = "errorMessage">Tên đăng nhập hoặc mật khẩu không đúng</div>
			</div>
			<%
			}
			}
			%>
			<!-- Xử lý ẩn báo lỗi khi nhập lại -->
			<script>
				// Lấy tham chiếu tới phần tử thông báo
				var errorMessage = document.getElementById('errorMessage');

				// Lắng nghe sự kiện nhập liệu trên trường nhập liệu
				document.getElementById('username').addEventListener('input',
						hideErrorMessage);
				document.getElementById('password').addEventListener('input',
						hideErrorMessage);

				// Hàm xử lý sự kiện input
				function hideErrorMessage() {
					errorMessage.style.display = 'none';
				}
			</script>
          <div class="text-center text-lg-start mt-4 pt-2">
            <button type="submit" class="btn btn-primary btn-lg"
              style="padding-left: 2.5rem; padding-right: 2.5rem;">Đăng nhập</button>
            <p class="small fw-bold mt-2 pt-1 mb-0">Không có tài khoản? <a href="/vtravel/trangdangki"
                class="link-danger">Đăng ký</a></p>
          </div>

        </form>
      </div>
    </div>
  </div>
</body>
</html>