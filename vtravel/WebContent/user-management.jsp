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
        <a href="Tour.jsp" class="button">Quản lý Tour</a> <!-- Đoạn mã mới -->
        <h1>Quản lý người dùng</h1>
    </div>
    <div class="container">
		<div>
		    <button onclick="addUser()">Thêm User</button>
		</div>
        <div>
        	<button onclick="listUser()">Danh sách tài khoản</button>
            <label for="showOptions">Hiển thị: </label>
            <select id="showOptions">
                <option value="all">Tất cả</option>
                <option value="user">User</option>
                <option value="admin">Admin</option>
            </select>
            
            
        </div>
        <div class="page-navigation">
            <label for="itemsPerPage">Số dòng/trang: </label>
            <select id="itemsPerPage">
                <option value="all">All</option>
                <option value="10">10</option>
                <option value="15">15</option>
                <option value="20">20</option>
            </select>
            <button id="prevPage">Trang trước</button>
            <span id="currentPage">1</span>
            <button id="nextPage">Trang sau</button>
        </div>
		<div class="search-box">
		    <label for="search">Tìm kiếm: </label>
		    <input type="text" id="search" placeholder="Nhập từ khoá tìm kiếm">
		    <button onclick="searchAccounts()">Tìm kiếm</button>
		</div>

        <div class="table-container">
			<table>
			    <tr  >
			        <th>Username</th>
			        <th>Email</th>
			        <th>Số điện thoại</th>
			        <th>Vai trò</th>
			        <th>Trạng thái</th>
			        <th>Hành động</th>
			    </tr>
			    <c:forEach var="account" items="${accounts}">
					<tr id="account-row-${account.id}">
			            <td contenteditable="false">${account.username}</td>
			            <td contenteditable="false">${account.email}</td>
			            <td contenteditable="false">${account.phoneNumber}</td>
			            <td contenteditable="false">${account.role}</td>
			            <td id="lock-${account.id}" contenteditable="false">${account.status}</td>
			            <td>
            				<button onclick="openEditForm(${account.id})">Sửa</button>	
			                <button onclick="viewDetails(${account.id})">Chi tiết</button>
			                <button onclick="lockAccount(${account.id})">Mở/khóa</button>
			                <button onclick="deleteAccount(${account.id})">Xóa</button>
			            </td>
			        </tr>
			    </c:forEach>
			</table>
        </div>
        
    </div>
    <script>
    function openEditForm(userId) {
        // Điều hướng tới trang update-user.jsp với userId là tham số
        window.location.href = 'update-user?command=LOAD&userId=' + userId;
    }
    function viewDetails(userId) {
        // Điều hướng tới trang update-user.jsp với userId là tham số
        window.location.href = 'detail-user?command=DETAIL&userId=' + userId;
    }
    function lockAccount(userId) {
        $.ajax({
            type: "POST",
            url: "lock",
            data: { userId: userId },
            success: function(data) {
                if (data === "success") {
                    // Tìm phần tử trạng thái dựa trên userId và cập nhật nó
                    var statusElement = $("#lock-" + userId);

                    if (statusElement.length) {
                        var currentStatus = statusElement.text();
                        var newStatus = (currentStatus === "lock") ? "unlock" : "lock";
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

    function deleteAccount(userId) {
        $.ajax({
            type: "POST",
            url: "delete",
            data: { userId: userId },
            success: function(data) {
                if (data === "success") {
                    // Tìm phần tử tài khoản dựa trên userId và ẩn nó
                    var accountElement = $("#account-row-" + userId);

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

    function addUser() {
        // Điều hướng tới trang update-user.jsp với userId là tham số
        window.location.href = "http://localhost:8080/Tour/addUser.jsp"
    }
    function listUser() {
        var showOptions = document.getElementById('showOptions');
        var selectedOption = showOptions.value;
        if (selectedOption === 'all') {
        	window.location.href = 'user-management?command=LIST_ALL';
        } else if (selectedOption === 'user') {
        	window.location.href = 'user-management?command=LIST_USER';
        } else if (selectedOption === 'admin') {
        	window.location.href = 'user-management?command=LIST_ADMIN';
        }
    }
    function searchAccounts() {
        var searchInput = document.getElementById('search');
        var searchTerm = searchInput.value.toLowerCase(); // Chuyển đổi từ khoá tìm kiếm thành chữ thường để tìm kiếm không phân biệt chữ hoa/chữ thường

        // Lặp qua danh sách tài khoản và ẩn/cất hiện dựa trên từ khoá tìm kiếm
        var accounts = document.querySelectorAll('table tr');
        for (var i = 1; i < accounts.length; i++) {
            var accountRow = accounts[i];
            var username = accountRow.querySelector('td:nth-child(1)').textContent.toLowerCase(); // Lấy tên người dùng trong hàng
            var email = accountRow.querySelector('td:nth-child(2)').textContent.toLowerCase(); // Lấy email trong hàng
            if (username.includes(searchTerm) || email.includes(searchTerm)) {
                accountRow.style.display = 'table-row'; // Hiển thị hàng nếu chứa từ khoá tìm kiếm trong email hoặc username
            } else {
                accountRow.style.display = 'none'; // Ẩn hàng nếu không chứa từ khoá tìm kiếm trong email hoặc username
            }
        }
    }
    document.addEventListener('DOMContentLoaded', function() {
        var itemsPerPageSelect = document.getElementById('itemsPerPage');
        var prevPageButton = document.getElementById('prevPage');
        var nextPageButton = document.getElementById('nextPage');
        var currentPageSpan = document.getElementById('currentPage');
        var allRecords = document.querySelectorAll('table tr');
        var totalRecords = allRecords.length - 1; // Trừ 1 để loại bỏ hàng tiêu đề

        // Số lượng bản ghi trên mỗi trang và trang hiện tại
        var itemsPerPage = 10; // Giá trị mặc định
        var totalPages = Math.ceil(totalRecords / itemsPerPage);
        var currentPage = 1;

        // Cập nhật hiển thị trang hiện tại
        function updatePage() {
            // Ẩn hoặc hiển thị các bản ghi dựa trên số lượng bản ghi trên mỗi trang và trang hiện tại
            var startIndex = (currentPage - 1) * itemsPerPage;
            var endIndex = currentPage * itemsPerPage;

            for (var i = 1; i < allRecords.length; i++) {
                if (i >= startIndex && i < endIndex) {
                    allRecords[i].style.display = 'table-row';
                } else {
                    allRecords[i].style.display = 'none';
                }
            }

            // Cập nhật hiển thị trang hiện tại
            currentPageSpan.textContent = 'Trang ' + currentPage + '/' + totalPages;

            // Kiểm tra nút "Trang trước" và "Trang sau"
            if (currentPage === 1) {
                prevPageButton.disabled = true;
            } else {
                prevPageButton.disabled = false;
            }

            if (currentPage === totalPages) {
                nextPageButton.disabled = true;
            } else {
                nextPageButton.disabled = false;
            }
        }

        // Xử lý khi người dùng thay đổi số lượng bản ghi trên mỗi trang
        itemsPerPageSelect.addEventListener('change', function() {
            var selectedValue = itemsPerPageSelect.value;
            if (selectedValue === 'all') {
                // Nếu chọn "All", hiển thị tất cả bản ghi
                itemsPerPage = totalRecords;
            } else {
                itemsPerPage = parseInt(selectedValue);
            }
            totalPages = Math.ceil(totalRecords / itemsPerPage);
            currentPage = 1;
            updatePage();
        });

        // Xử lý khi người dùng bấm vào nút "Trang trước"
        prevPageButton.addEventListener('click', function() {
            if (currentPage > 1) {
                currentPage--;
                updatePage();
            }
        });

        // Xử lý khi người dùng bấm vào nút "Trang sau"
        nextPageButton.addEventListener('click', function() {
            if (currentPage < totalPages) {
                currentPage++;
                updatePage();
            }
        });

        // Ban đầu cập nhật trang hiển thị
        updatePage();
    });



	</script>
    
</body>
</html>

