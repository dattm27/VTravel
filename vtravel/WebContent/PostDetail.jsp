<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<style>
	h1 {
		padding: 5vh 0 5vh;
	}
	img {
		width: 50%;
	}
	#Content {
		white-space: pre-wrap;
		word-wrap: break-word;
	  	max-width: 100vw;
	}
	</style>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- bootstrap css -->
	<link rel="stylesheet"
		href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<!-- Thêm script của Bootstrap Modal -->
	<script
		src="https://cdnjs.cloudflare.com/aj
		    ax/libs/twitter-bootstrap/5.0.2/js/bootstrap.bundle.min.js"></script>
	<title>VTravel - Bài viết</title>
</head>
<body>
	<!-- Header -->
	<jsp:include page="navbar.jsp"></jsp:include>

	<h1>${details.name}</h1>
	<p>${details.shortDescription}</p>
	<img src="${details.image}" class="rounded mx-auto d-block">
	<div id="Content">${details.content}</div>

</body>
</html>