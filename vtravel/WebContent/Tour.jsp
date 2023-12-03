<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý người dùng du lịch</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .header {
            background-color: rgb(255, 255, 255);
            padding: 10px;
            text-align: left;
        }
        h1 {
            color: black;
        }
        .container {
            margin: 20px;
        }
        .button {
            background-color: #008CBA;
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
        }
        .table-container {
            margin-top: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            text-align: left;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
        .page-navigation {
            margin-top: 20px;
        }
        .pagination {
            display: flex;
            list-style: none;
            padding: 0;
            justify-content: center;
        }
        .pagination li {
            margin: 5px;
        }
        /* CSS cho ô tìm kiếm */
		.search-box {
		    float: right; /* Căn chỉều sang bên phải */
		    margin-right: 100px; /* Khoảng cách từ bên phải */
		}
    </style>
    <style>
	    /* CSS cho modal */
	    .modal {
	        display: none;
	        position: fixed;
	        top: 0;
	        left: 0;
	        width: 100%;
	        height: 100%;
	        background-color: rgba(0, 0, 0, 0.7);
	    }
	
	    .modal-content {
	        background-color: #fff;
	        width: 50%;
	        margin: 0 auto;
	        margin-top: 10%;
	        padding: 20px;
	        border: 1px solid #ccc;
	        border-radius: 5px;
	    }
	    /* Định dạng cho lớp .status */
		.status.lock {
		    background-color: #FF0000; /* Màu đỏ cho trạng thái lock */
		    color: white;
		    padding: 5px 10px;
		    border-radius: 5px;
		}
		
		.status.unlock {
		    background-color: #00FF00; /* Màu xanh cho trạng thái unlock */
		    color: white;
		    padding: 5px 10px;
		    border-radius: 5px;
		}
	    
	</style>

</head>
<body >
    <div class="header">
        <a href="#" class="button">Trang chủ</a>
        <a href="user-management.jsp" class="button">Quản lý Tài khoản</a> <!-- Đoạn mã mới -->
        <h1>Quản lý Tour</h1>
    </div>
    <div class="container">
		<div>
		    <button onclick="addTour()">Thêm Tour</button>
		</div>
        <div>
        	<button onclick="listTour()">Danh sách Tour</button>          
        </div>
        <div class="page-navigation">
            <label for="itemsPerPage">Số dòng trên 1 trang: </label>
            <select id="itemsPerPage">
                <option value="5">5</option>
                <option value="10">10</option>
                <option value="15">15</option>
                <option value="20">20</option>
                <option value="all">All</option>
            </select>
            <button id="prevPage">Trang trước</button>
            <span id="currentPage">Trang 1</span>
            <button id="nextPage">Trang sau</button>
        </div>
		<div class="search-box">
		    <label for="search">Tìm kiếm: </label>
		    <input type="text" id="search" placeholder="Nhập từ khoá tìm kiếm">
		    <button onclick="searchTours()">Tìm kiếm</button>
		</div>

        <div class="table-container">
			<table>
			    <tr>
			        <th>Tour Name</th>
			        <th>SL còn lại</th>
			        <th>Ngày BĐ</th>
			        <th>Ngày KT</th>
			        <th>Trạng thái</th> <!-- Thêm cột Trạng thái -->
			        <th>Hành động</th>
			    </tr>
			    <c:forEach var="tour" items="${tours}">
			        <tr id="tour-row-${tour.id_tour}">
			            <td>${tour.tourName}</td>
			            <td>${tour.number_left}</td>
			            <td>${tour.date_begin}</td>
			            <td>${tour.date_end}</td>
			            <td id="lock-${tour.id_tour}">${tour.status}</td>
			            <td>
            				<button onclick="openEditForm(${tour.id_tour})">Sửa</button>	
			                <button onclick="viewDetails(${tour.id_tour})">Chi tiết</button>
			                <button onclick="lockTour(${tour.id_tour})">Mở/khóa</button>
			                <button onclick="deleteTour(${tour.id_tour})">Xóa</button>
			            </td>
			        </tr>
			    </c:forEach>
			</table>

        </div>
        
    </div>
    <script>
    function listTour() {
        	window.location.href = 'tour?command=LIST';
    }
    function openEditForm(tourId) {
        // Điều hướng tới trang update-user.jsp với userId là tham số
        window.location.href = 'update-tour?command=LOAD&tourId=' + tourId;
    }
    function viewDetails(tourId) {
        // Điều hướng tới trang update-user.jsp với userId là tham số
        window.location.href = 'detail-tour?command=DETAIL&tourId=' + tourId;
    }
    function lockTour(tourId) {
        $.ajax({
            type: "POST",
            url: "lock",
            data: { tourId: tourId },
            success: function(data) {
                if (data === "success") {
                    // Tìm phần tử trạng thái dựa trên userId và cập nhật nó
                    var statusElement = $("#lock-" + tourId);

                    if (statusElement.length) {
                        var currentStatus = statusElement.text();
                        var newStatus = (currentStatus === "on") ? "off" : "on";
                        statusElement.text(newStatus);
                    }
                } else {
                    alert("Không thể thực hiện hành động lock.");
                }
            },
            error: function() {
                alert("Lỗi khi gọi servlet lock.");
            }
        });
    }
    function deleteTour(tourId) {
        $.ajax({
            type: "POST",
            url: "delete",
            data: { tourId: tourId },
            success: function(data) {
                if (data === "success") {
                    // Tìm phần tử tài khoản dựa trên userId và ẩn nó
                    var accountElement = $("#tour-row-" + tourId);

                    if (accountElement.length) {
                        accountElement.hide(); // Ẩn phần tử tài khoản
                    } else {
                        alert("Không tìm thấy phần tử tài khoản để ẩn.");
                    }
                } else {
                    alert("Không thể thực hiện hành động xóa.");
                }
            },
            error: function() {
                alert("Lỗi khi gọi servlet delete.");
            }
        });
    }
    function addTour() {
        // Điều hướng tới trang update-user.jsp với userId là tham số
        window.location.href = "http://localhost:8080/Tour/addTour.jsp"
    }
    function searchTours() {
        var searchInput = document.getElementById('search');
        var searchTerm = searchInput.value.toLowerCase(); // Chuyển đổi từ khoá tìm kiếm thành chữ thường để tìm kiếm không phân biệt chữ hoa/chữ thường

        // Lặp qua danh sách tour và ẩn/cất hiện dựa trên từ khoá tìm kiếm
        var tours = document.querySelectorAll('table tr');
        for (var i = 1; i < tours.length; i++) {
            var tourRow = tours[i];
            var tourName = tourRow.querySelector('td:nth-child(1)').textContent.toLowerCase(); // Lấy tên tour trong hàng
            if (tourName.includes(searchTerm)) {
                tourRow.style.display = 'table-row'; // Hiển thị hàng nếu chứa từ khoá tìm kiếm trong tên tour
            } else {
                tourRow.style.display = 'none'; // Ẩn hàng nếu không chứa từ khoá tìm kiếm trong tên tour
            }
        }
    }

	</script>
    
</body>
</html>

