<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chỉnh sửa thông tin người dùng</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .form-container {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
        }
        .form-container label {
            display: block;
            margin-bottom: 5px;
        }
        .form-container input {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
        .form-container input[type="text"][readonly="readonly"] {
            background-color: #fff;
        }
        .form-container input[type="password"][readonly="readonly"] {
            background-color: #fff;
        }
        .form-container input[type="text"]:not([readonly="readonly"]),
        .form-container input[type="password"]:not([readonly="readonly"]) {
            background-color: #fff; /* Các trường có thể chỉnh sửa vẫn có màu nền trắng */
        }
        .form-container input[type="submit"] {
            background-color: #008CBA;
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="form-container">
    	<h1>Thông tin người dùng</h1>
        <form>
		    <label for="editTourId">Tour ID:</label>
		    <input type="text" id="editTourId" name="tourId" value="${tour.id_tour}" readonly="readonly" />
		    <label for="editTourName">Tên Tour:</label>
		    <input type="text" id="editTourName" name="tourName" value="${tour.tourName}" />
		    <label for="editPrice">Giá:</label>
		    <input type="text" id="editPrice" name="price" value="${tour.price}" />
		    <label for="editNumberLeft">SL còn lại:</label>
		    <input type="text" id="editNumberLeft" name="numberLeft" value="${tour.number_left}" />
		    <label for="editDateBegin">Ngày BĐ:</label>
		    <input type="text" id="editDateBegin" name="dateBegin" value="${tour.date_begin}" />
		    <label for="editDateEnd">Ngày KT:</label>
		    <input type="text" id="editDateEnd" name="dateEnd" value="${tour.date_end}" />
		    <label for="editDiscount">Giảm giá (%):</label>
		    <input type="text" id="editDiscount" name="discount" value="${tour.discount}" />
		    <label for="editDiscountPeriod">Khoảng TG giảm(ngày):</label>
		    <input type="text" id="editDiscountPeriod" name="discountPeriod" value="${tour.discount_period}" />
		    <label for="editStatus">Trạng thái:</label>
		    <input type="text" id="editStatus" name="status" value="${tour.status}" />
		    <input type="button" value="Quay lại" onclick="window.history.back()" />
		</form>
    </div>
    
</body>
</html>
