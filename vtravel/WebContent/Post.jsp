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
</head>

<body>
	<!-- Header của trang web -->
	<jsp:include page="navbar.jsp" />

	<!-- Nội dung của trang web -->
	<main>
		<!-- Hiển thị các bài viết trong trang quản lý bài viết -->
		
		
		<div class="container">
			<div class ="d-flex flex-row">
				<h2 class="text-left mt-3 mb-3">Kinh nghiệm du lịch</h2>
				<div class="input-group mt-3 mb-3 col-md-3 ml-auto " >
			  		<div class="input-group-prepend">
			    <span class="input-group-text" >Tìm kiếm</span>
			  </div>
			  <input type="text" class="form-control" id="searchInput" name="search" placeholder="VD: Nha Trang"   oninput="searchData('data-search-1','data-search-2')">
			</div>
			</div>
			<c:forEach items="${POST_LIST}" var="post">
				<div class="media mt-3 mb-3" style="max-width: 100%;"  data-search-1="${post.name}" data-search-2="${post.shortDescription}">
					<div class="row g-0">
						<c:url var="POST_DETAIL" value="PostControllerServlet">
							<c:param name="command" value="POST_DETAIL" />
							<c:param name="ID" value="${post.ID}" />
						</c:url>
						<div class="col-md-4">
							<a href="${POST_DETAIL}" style="text-decoration: none;"> <img src="${post.image}"
								class="align-self-center mr-3" alt="..."
								style="width: 100%; height: 200px; object-fit: cover;">
							</a>
						</div>
						<div class="col-md-8">
							<div class="media-body">
								<a href="${POST_DETAIL}" style="text-decoration: none;"><h4 class="mt-0">${post.name}</h4></a>
								<p class="card-text">${post.shortDescription}</p>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</main>
	<!-- Javascript xử lý  tìm kiếm -->
	
</body>
</html>