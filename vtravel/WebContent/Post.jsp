<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>V Travel - Bài viết</title>
<!-- bootstrap css -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="css/Post.css">
</head>

<body>
	<!-- Header của trang web -->
	<jsp:include page="navbar.jsp" />

	<!-- Nội dung của trang web -->
	<main>
		<!-- Hiển thị các bài viết trong trang quản lý bài viết -->
		<h1>Kinh nghiệm du lịch</h1>
		<c:forEach items="${POST_LIST}" var="post">
			<div class="Post">
				<c:url var="POST_DETAIL" value="PostControllerServlet">
					<c:param name="command" value="POST_DETAIL" />
					<c:param name="ID" value="${post.ID}" />
				</c:url>
				<a href="${POST_DETAIL}" class="ImageLink"> <img
					src="${post.image}">
				</a>
				<div class="PostContent">
					<a href="${POST_DETAIL}"><h2>${post.name}</h2></a>
					<p>${post.shortDescription}</p>
				</div>
			</div>
		</c:forEach>
	</main>
</body>

</html>