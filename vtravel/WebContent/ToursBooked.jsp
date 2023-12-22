<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "com.PVHoang.model.BookedTour" import = "java.util.ArrayList"
    %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>	
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh sach tour da dat</title>
<!-- Thư viện CSS Bootstrap -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Thêm script của Bootstrap Modal -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.2/js/bootstrap.bundle.min.js"></script>
   <!-- link file css cho hero ssection -->
   <link rel="stylesheet" href="css/index.css">
</head>
<body>
	
	<jsp:include page="navbar.jsp" />
	
	<!-- ----------------------------------------  -->
	<h3>Danh sách các tour đã đặt của khách hàng haha <b> Trần Hoàng Sơn </b></h3>
	
	<form class="row mt-2 gy-2 gx-3 align-items-center" style="margin-left: 20px">
		<div class="input-group mb-3">
			  <label class="input-group-text" for="inputGroupSelect01">Sắp xếp theo</label>
			  <select class="form-select" id="inputGroupSelect01" style="width: 10px" name = "kieusapxep">
			    <option selected>  </option>
			    <option value="1">Giá tiền</option>
			    <option value="2">Ngày xuất phát</option>
			    <option value="3">Trạng thái</option>
			  </select>
		</div>
		<input type="text" name="ID" value='<%= session.getAttribute("ID") %>' style="display: none;">
		<div class="">
			<button type="submit" class="btn btn-primary">Lọc</button>
		</div>
	</form>
	
	<br>
	
	<%ArrayList<BookedTour> booked_tours = (ArrayList<BookedTour>) request.getAttribute("bookedTours");%>
	<table  class="table table-striped-columns" border = "4" >
	  <thead>
	    <tr>
	      <th scope="col">Mã tour</th>
	      <th scope="col">Ngày đặt</th>
	      <th scope="col">Tên Tour</th>
	      <th scope="col">Giá tiền</th>
	      <th scope="col">Trạng thái</th>
	    </tr>
	  </thead>
	  <tbody>
	     <%for(BookedTour tour: booked_tours){ %>
			  	<tr>
			  		<th scope="row"><%= tour.getBooked_ID() %></th>
			  		<td> <%= tour.getBooked_date()%>  </td>
			  		<td> <a href="/vtravel/tours?id=<%= tour.getBooked_ID() %>"> <%= tour.getTour_name()%> </a> </td>
			  		<td> <%= tour.getPrice() %> </td>
			  		<td> <%= tour.getStatus() %></td>
			  	</tr>
		<%} %> 
	  </tbody>
	</table>
	<nav aria-label="Page navigation example">
	  <ul class="pagination justify-content-center">
	    <c:if test="${page != 1 }">
		    <li class="page-item">
		      <a class="page-link" href="/vtravel/BookedTour?kieusapxep=<%=request.getParameter("kieusapxep") == null ? "" : request.getParameter("kieusapxep")%>&page=${ page - 1 }&ID=<c:out value = "${sessionScope.ID}"/>">Previous</a>
		    </li>
	    </c:if>
	    <c:forEach var="i" begin="1" end="${totalPage}">
	   		 <c:choose>
	   		 	 <c:when test="${page == i}">
			   		 <li class="page-item active">
			   		 	<a class="page-link" href="/vtravel/BookedTour?kieusapxep=<%=request.getParameter("kieusapxep") == null ? "" : request.getParameter("kieusapxep")%>&page=${ i }&ID=<c:out value = "${sessionScope.ID}"/>">${ i }</a>
			   		 </li>
		   		 </c:when>
		   		 <c:otherwise>
		   		 	<li class="page-item">
			   		 	<a class="page-link" href="/vtravel/BookedTour?kieusapxep=<%=request.getParameter("kieusapxep") == null ? "" : request.getParameter("kieusapxep")%>&page=${ i }&ID=<c:out value = "${sessionScope.ID}"/>">${ i }</a>
					</li>
		   		 </c:otherwise>
	   		 </c:choose>
	    </c:forEach>
	    <c:if test="${page < totalPage}">
		    <li class="page-item">
		      <a class="page-link" href="/vtravel/BookedTour?kieusapxep=<%=request.getParameter("kieusapxep") == null ? "" : request.getParameter("kieusapxep")%>&page=${ page + 1 }&ID=<c:out value = "${sessionScope.ID}"/>">Next</a>
		    </li>
	    </c:if>
	  </ul>
	</nav>
</body>
</html>