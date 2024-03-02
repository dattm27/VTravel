<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<nav class="navbar navbar-expand-lg navbar-light sticky-top bg-light">
	<c:url var="WELCOME" value="WelcomeControllerServlet">
	</c:url>
	<a class="navbar-brand" href="${WELCOME}">VTravel</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav ml-auto">
			<li class="nav-item ">
			
			<a class="nav-link" href="${WELCOME}">Trang chủ
					<span class="sr-only">(current)</span>
			</a></li>
			<c:url var = "LIST_ALL_TOURS" value = "TourControllerServlet">
				<c:param name="command" value = "LIST_ALL_TOURS"/>
			</c:url> 
			<li class="nav-item"><a class="nav-link" href="${LIST_ALL_TOURS}">Tour phổ
					thông</a></li>
			<li class="nav-item"><a class="nav-link" href="custom_tour.jsp">Tour tuỳ
					chọn</a></li>
					<!-- Hiển thị trang Bài viết -->
			<c:url var="LIST_ALL_POST" value="PostControllerServlet">
				<c:param name="command" value="LIST_ALL_POST" />
			</c:url>
			<li class="nav-item"><a class="nav-link" href="${LIST_ALL_POST}">Bài viết</a> <!-- Check if the user is logged in -->
				<c:if test="${empty sessionScope.username}">
					<!-- Display Đăng nhập link if not logged in -->
					<li class="nav-item"><a class="nav-link" href="login.jsp"
						style="margin-right: 50px">Đăng nhập</a></li>
				</c:if> <!-- Display dropdown if the user is logged in --> <c:if
					test="${not empty sessionScope.username and sessionScope.role eq 'user'}">
					<li class="nav-item dropdown" style="margin-right: 80px"><a
						class="nav-link dropdown-toggle" id="navbarDropdown" role="button"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							${sessionScope.username} </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<%-- <a class="dropdown-item" href="/vtravel/BookedTour?ID=<c:out value = "${sessionScope.ID}"/>">Tour của tôi</a>  --%>
							<c:url var="LIST_MY_TOUR" value="TourControllerServlet">
								<c:param name="command" value="LIST_MY_TOUR" />
								<c:param name= "ID" value = "${sessionScope.ID}"/>
							</c:url>
							 <a class="dropdown-item" href="${LIST_MY_TOUR}">Tour của tôi</a>
							<a
								class="dropdown-item" href="user_info.jsp">Thông tin cá nhân</a>
							<div class="dropdown-divider"></div>
							<!-- tạo xử lý yêu cầu đăng xuất  -->
							<c:url var="LOG_OUT" value="SessionControllerServlet">
								<c:param name="command" value="LOG_OUT" />
							</c:url>
							<a class="dropdown-item" href="${LOG_OUT}">Đăng xuất</a>
						</div></li>
				</c:if>
				 <!-- Display dropdown if the admin is logged in --> 
				 <c:if
					test="${not empty sessionScope.username and sessionScope.role eq 'admin'}">
					<li class="nav-item dropdown" style="margin-right: 80px"><a
						class="nav-link dropdown-toggle" id="navbarDropdown" role="button"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							${sessionScope.username} </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<c:url var="LIST_ALL" value="user-management">
								<c:param name="command" value="LIST_ALL" />
							</c:url>
							<a class="dropdown-item" href="${LIST_ALL}">Quản lý user</a>
							<!-- tạo link xử lý yêu cầu quản lý tour phổ thông -->
							<c:url var="TOURS_MANAGEMENT" value="TourControllerServlet">
								<c:param name="command" value="TOURS_MANAGEMENT" />
							</c:url>
							<a class="dropdown-item" href="${TOURS_MANAGEMENT}">Quản lý tour</a>
							<!-- tạo link xử lý yêu cầu quản lý custom tour   -->
							<c:url var="LIST_ALL_CUSTOM_TOUR_REQUEST" value="TourControllerServlet">
								<c:param name="command" value="LIST_ALL_CUSTOM_TOUR_REQUEST" />
							</c:url>
							<a class="dropdown-item" href="${LIST_ALL_CUSTOM_TOUR_REQUEST}">Quản lý custom tour</a> 
							
							<c:url var="POSTS_MANAGEMENT" value="post-management">
								<c:param name="command" value="GET_ALL_POSTS" />
							</c:url>
							<a
								class="dropdown-item" href="${POSTS_MANAGEMENT}">Quản lý bài viết</a>
							<div class="dropdown-divider"></div>
							<!-- tạo xử lý yêu cầu đăng xuất  -->
							<c:url var="LOG_OUT" value="SessionControllerServlet">
								<c:param name="command" value="LOG_OUT" />
							</c:url>
							<a class="dropdown-item" href="${LOG_OUT}">Đăng xuất</a>
						</div></li>
				</c:if>
			</li>
		</ul>
	</div>
	<!-- thêm js cho boostrap -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	
</nav>
