<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm Tour Mới</title>
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
        .form-container select {
            width: 106%;
            min-width: 100px;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
            font-size: 14px;
        }
        .form-container input[type="submit"] {
            background-color: #008CBA;
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            cursor: pointer;
        }
        .password-hint {
	    	font: italic 12px Arial;
	    	color: #777;
	  	}
    </style>
</head>
<body>
<script>
    function Exit2() {
        var tourName = document.getElementById('editTourName').value;
        var price = document.getElementById('editPrice').value;
        var numberLeft = document.getElementById('editNumberLeft').value;
        var dateBegin = document.getElementById('editDateBegin').value;
        var dateEnd = document.getElementById('editDateEnd').value;
        var last = document.getElementById('editLast').value;
        var discount = document.getElementById('editDiscount').value;
        var discountPeriod = document.getElementById('editDiscountPeriod').value;

        var url = document.getElementById('editUrl').value;

        if (!tourName || !price || !numberLeft || !dateBegin || !dateEnd || !discount || !discountPeriod  || !last || !url) {
            alert('Vui lòng điền đầy đủ thông tin.');
            return;
        }

        var url1 = 'tour?command=ADD' +
            '&tourName=' + encodeURIComponent(tourName) +
            '&price=' + parseInt(price) +
            '&numberLeft=' + parseInt(numberLeft) +
            '&dateBegin=' + dateBegin +
            '&dateEnd=' + dateEnd +
            '&discount=' + parseInt(discount) +
            '&discountPeriod=' + parseInt(discountPeriod) +
            '&status=on' +
            '&last=' + parseInt(last) +
            '&url=' + encodeURIComponent(url);
        window.location.href = url1;
    }
</script>
<div class="form-container">
    <h1>Thêm Tour Mới</h1>
    <form>
        <label for="editTourName">Tên Tour:</label>
        <input type="text" id="editTourName" name="tourName" />

        <label for="editPrice">Giá:</label>
        <input type="text" id="editPrice" name="price" />

        <label for="editNumberLeft">Số lượng còn lại:</label>
        <input type="text" id="editNumberLeft" name="numberLeft" />

        <label for="editDateBegin">Ngày Bắt đầu:
        	<span class="password-hint">(yyyy-MM-dd HH:mm:ss)</span></label>
        <input type="text" id="editDateBegin" name="dateBegin" />

        <label for="editDateEnd">Ngày Kết thúc:
        	<span class="password-hint">(yyyy-MM-dd HH:mm:ss)</span></label>
        <input type="text" id="editDateEnd" name="dateEnd" />
        
        <label for="editLast">Last:</label>
        <input type="text" id="editLast" name="last" />

        <label for="editDiscount">Giảm giá (%):</label>
        <input type="text" id="editDiscount" name="discount" />

        <label for="editDiscountPeriod">Khoảng thời gian giảm giá (ngày):</label>
        <input type="text" id="editDiscountPeriod" name="discountPeriod" />
        
        <label for="editUrl">URL:</label>
        <input type="text" id="editUrl" name="url" />

        <input type="button" value="Xác nhận" onclick="Exit2()" />
        <input type="button" value="Hủy" onclick="window.history.back()" />
    </form>
</div>
</body>
</html>
