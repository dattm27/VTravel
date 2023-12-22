<%@page import="java.util.ArrayList"%>
<%@page import="com.PVHoang.model.Posts"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Thư viện CSS Bootstrap -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Thêm script của Bootstrap Modal -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.2/js/bootstrap.bundle.min.js"></script>
   <!-- link file css cho hero ssection -->
   <link rel="stylesheet" href="css/index.css">
    <title>PostList</title>
</head>
<body>
	<jsp:include page="navbar.jsp" />
	<!-- Tạo bảng -->
    <div class = "container">
        <div class = "row">
            <div class="col-md-12">
                <table class="table">
                    <thead>
                      <tr>
                        <th scope="col">id</th>
                        <th scope="col">user_id</th>
                        <th scope="col">post date</th>
                      </tr>
                    </thead>
                    <tbody>
                    <!-- Xet từng phàn tử của ArrayList pots đã đc set attribute và in ra các thuộc tính như dưới -->
                    <c:forEach items = "${posts}" var = "post">
                      <tr>
                        <th scope="row">
                        	<c:out value = "${ post.getId() }"/>
                        </th>
                        <td>
                        	<c:out value = "${ post.getUser_id() }"/>
                        </td>
                        <td>
                        	<c:out value = "${ post.getPost_date() }"/>
                        </td>
                        <td>
                        	<a href="/vtravel/posts?id=<c:out value = "${ post.getId() }"/>">Check it out</a>
						</td>
                      </tr>
                     </c:forEach>
                    </tbody>
                  </table>
            </div>
        </div>
    </div>
    <!-- bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
</body>
</html>