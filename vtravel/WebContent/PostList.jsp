<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>VTravel - Trang web đặt tour du lịch</title>
<link rel="stylesheet" href="css/Post.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Doppio+One&family=Roboto&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>

<body>
	<c:url var="LIST_ALL_POST" value="PostControllerServlet">
		<c:param name="command" value="LIST_ALL_POST" />
	</c:url>
	<!-- Header của trang web -->
	<header class="Header">
		<a href="" class="Logo"> VTravel </a>
		<nav>
			<a href=""> Đặt tour </a> <a href=""> Tạo tour yêu thích </a> <a
				href=""> Thông tin cá nhân </a> <a href="${LIST_ALL_POST}"> Mạng
				xã hội </a>
		</nav>
		<a href="" id="LoginButton"> Đăng nhập </a>
	</header>

	<!-- Nội dung của trang web -->
	<main>
		<!-- Hiển thị các bài viết trong trang quản lý bài viết -->
		<h1>Kinh nghiệm du lịch</h1>
		<c:forEach items="${POST_LIST}" var="post">
			<div class="Post">
				<a href="" class="ImageLink"> <img src="images/VinhHaLong.png">
				</a>
				<div class="PostContent">
					<a href=""><h2>${post.name}</h2></a>
					<p>${post.shortDescription}</p>
				</div>
			</div>
		</c:forEach>
	</main>
	<!-- Footer của trang web -->
	<footer>
		<div class="Footer">
			<a href="" class="Logo"> VTravel </a>
			<div class="footerContainer">
				<div class="socialIcon">
					<a href=""> <i class="fa-brands fa-facebook"></i>
					</a> <a href=""> <i class="fa-brands fa-instagram"></i>
					</a> <a href=""> <i class="fa-brands fa-twitter"></i>
					</a> <a href=""> <i class="fa-brands fa-google-plus"></i>
					</a> <a href=""> <i class="fa-brands fa-youtube"></i>
					</a>
				</div>
				<div class="footerNav">
					<ul>
						<li><a href=""> Đặt tour </a></li>
						<li><a href=""> Tạo tour yêu thích </a></li>
						<li><a href=""> Thông tin cá nhân </a></li>
						<li><a href=""> Mạng xã hội </a></li>
					</ul>
				</div>
			</div>
		</div>
		<p class="footerBottom">
			Bản quyền của VTravel ® 2023. Bảo lưu mọi quyền.<br> Ghi rõ
			nguồn "www.vtravel.com.vn" ® khi sử dụng lại thông tin từ website
			này.<br> Số giấy phép kinh doanh lữ hành Quốc tế:
			79-234/2014/TCDL-GP LHQT
		</p>
	</footer>
</body>

</html>