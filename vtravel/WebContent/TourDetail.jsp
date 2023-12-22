<%@page import="java.util.ArrayList"%>
<%@page import="com.PVHoang.model.Tours"%>
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.2/js/bootstrap.bundle.min.js"></script>    <title>TourDetail</title>
</head>
<body>
	
	<jsp:include page="navbar.jsp" />
	
    <div class = "container">
    	<!-- Đặt biến tour để có thể get thuộc tính và in ra màn hình -->
    	<% Tours tour = (Tours)request.getAttribute("tour"); %>
        <h2>Tour id: </h2>
        <p><c:out value = "${tour.getId()}"/></p>
        <h2>Price: </h2> 
        <p><c:out value = "${tour.getPrice()}"/></p>
        <h2>Max number of tourists: </h2> 
        <p><c:out value = "${tour.getMax_number_tourist()}"/></p>
        <h2>Tour name: </h2> 
        <p><c:out value = "${tour.getTour_name()}"/></p>
        <h2>Discount: </h2> 
        <p><c:out value = "${tour.getDiscount()}"/></p>
        <h2>Start place: </h2> 
        <p><c:out value = "${tour.getStart_place()}"/></p>
        <h2>Description: </h2> 
        <p> <%= tour.getDescription() %> </p>
        <h2>Start date: </h2> 
        <p><c:out value = "${tour.getStart_date()}"/></p>
        <h2>End date: </h2> 
        <p><c:out value = "${tour.getEnd_date()}"/></p>
        <h2>Start discount: </h2> 
        <p><c:out value = "${tour.getStart_discount()}"/></p>
        <h2>End discount: </h2> 
        <p><c:out value = "${tour.getEnd_discount()}"/></p>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
</body>
</html>