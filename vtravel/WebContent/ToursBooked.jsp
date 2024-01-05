<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "vtravel.Booking" import = "java.util.ArrayList" import = "vtravel.Tour"
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
	<h3>Danh sách các tour đã đặt của khách hàng <b> ${sessionScope.username} </b></h3>
	
	<form class="row mt-2 gy-2 gx-3 align-items-center" style="margin-left: 20px">
		<div class="input-group mb-3">
			  <label class="input-group-text" for="inputGroupSelect01">Trạng thái</label>
			  <select class="form-select" id="inputGroupSelect01" style="width: 200px" name = "kieusapxep">
			    <option selected>  </option>
			    <option value="1">Đang chờ thanh toán</option>
			    <option value="2">Đang thực hiện</option>
			    <option value="3">Đã hoàn thành</option>
			  </select>
		</div>
		<input type="text" name="ID" value='<%= session.getAttribute("ID") %>' style="display: none;">
		<div class="">
			<button type="submit" class="btn btn-primary">Lọc</button>
		</div>
	</form>
	
	<br>
	
	<%ArrayList<Booking> booked_tours = (ArrayList<Booking>) request.getAttribute("bookedTours");%>
	<%ArrayList<Tour> tours = (ArrayList<Tour>) request.getAttribute("tours");%>
	<table  class="table table-striped-columns" border = "4" >
	  <thead>
	    <tr>
	      <th scope="col">Mã đơn đặt</th>
	      <th scope="col">Ngày đặt</th>
	      <th scope="col">Mã tour</th>
	      <th scope="col">Tên Tour</th>
	      <th scope="col">Số người</th>
	      <th scope="col">Tổng tiền</th>
	      <th scope="col">Lưu ý</th>
	      <th scope="col">Trạng thái</th>
	    </tr>
	  </thead>
	  <tbody>
	  	 <% int i = 0; %>
	     <%for(Booking tour: booked_tours){ %>
			  	<tr>
			  		<th scope="row"><%= tour.getID() %></th>
			  		<td> <%= tour.getCreatedDate()%>  </td>
			  		<td> <%= tour.getTourID()%> </td>
			  		<td> <a href="/vtravel/TourControllerServlet?command=DETAIL_TOUR_PAGE&ID=<%= tour.getTourID()%>"> <%= tours.get(i).getName() %> </a> </td>
			  		<td> <%= tour.getNumberOfTourists() %> </td>
			  		<td> <%= tour.getNumberOfTourists() * tours.get(i).getPrice() %> </td>
			  		<td> <%= tour.getNote() %> </td>			  		
			  		<td> <%= tour.getStatus() %></td>
			  	</tr>
		<% i++; }%> 
	  </tbody>
	</table>
</body>
</html>