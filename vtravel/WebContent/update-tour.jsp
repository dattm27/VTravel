<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chỉnh sửa thông tin Tour</title>
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
            background-color: #f2f2f2;
        }
        .form-container input[type="password"][readonly="readonly"] {
            background-color: #f2f2f2;
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
	    <form >
			<input type="hidden" id="tourId" name="tourId" value="${tour.id_tour}" />
	        <label for="editTourName">Tên tour:</label>
	        <input type="text" id="editTourName" name="tourName" value="${tour.tourName}" />
	        <label for="editPrice">Giá:</label>
	        <input type="text" id="editPrice" name="price" value="${tour.price}" />
	        <label for="editNumberLeft">SL còn lại:</label>
	        <input type="text" id="editNumberLeft" name="numberLeft" value="${tour.number_left}" />
	        <label for="editDateBegin">Ngày BĐ:</label>
	        <input type="text" id="editDateBegin" name="dateBegin" value="${tour.date_begin}" />
	        <label for="editDateEnd">Ngày KT:</label>
	        <label for="editLast">Thời gian cuối cùng (last):</label>
			<input type="text" id="editLast" name="last" value="${tour.last}" />	        
	        <input type="text" id="editDateEnd" name="dateEnd" value="${tour.date_end}" />
	        <label for="editDiscount">Giảm giá (%):</label>
	        <input type="text" id="editDiscount" name="discount" value="${tour.discount}" />
	        <label for="editDiscountPeriod">Khoảng TG giảm(ngày):</label>
	        <input type="text" id="editDiscountPeriod" name="discountPeriod" value="${tour.discount_period}" />
	        <label for="editUrl">URL:</label>
			<input type="text" id="editUrl" name="url" value="${tour.url}" />	        
	        <label for="editStatus">Trạng thái:</label>
	        <input type="text" id="editStatus" name="status" value="${tour.status}" />
			<input type="button" value="Lưu" onclick="Exit1()" />
			<input type="button" value="Hủy" onclick="window.history.back()" />
	    </form>
	</div>

    <script>
    function Exit1() {
        var id = document.getElementById('tourId').value;
        var tourName = document.getElementById('editTourName').value;
        var price = document.getElementById('editPrice').value;
        var number_left = document.getElementById('editNumberLeft').value;
        var date_begin = document.getElementById('editDateBegin').value;
        var last = document.getElementById('editLast').value;
        var date_end = document.getElementById('editDateEnd').value;
        var url = document.getElementById('editUrl').value;
        var discount = document.getElementById('editDiscount').value;
        var discount_period = document.getElementById('editDiscountPeriod').value;
        var status = document.getElementById('editStatus').value;

        var updateUrl = 'tour?command=UPDATE&tourId=' + id +
            '&tourName=' + encodeURIComponent(tourName) +
            '&price=' + parseInt(price) +
            '&number_left=' + parseInt(number_left) +
            '&date_begin=' + date_begin +
            '&last=' + parseInt(last) +
            '&date_end=' + date_end +
            '&url=' + encodeURIComponent(url) +
            '&discount=' + parseInt(discount) +
            '&discount_period=' + parseInt(discount_period) +
            '&status=' + encodeURIComponent(status);

        window.location.href = updateUrl;
    }



	</script>
</body>
</html>
