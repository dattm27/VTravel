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
		.form-container select {
		    width: 106%; /* Để ô select box cùng chiều rộng với các ô khác */
		    min-width: 100px; /* Chiều rộng tối thiểu (điều chỉnh kích thước theo nhu cầu) */
		    padding: 10px;
		    margin-bottom: 10px;
		    border: 1px solid #ccc;
		    border-radius: 3px;
		}
		.role-option {
		    padding: 10px;
		    margin-bottom: 10px;
		    border: 1px solid #ccc;
		    border-radius: 3px;
	        font-size: 14px; /* Điều chỉnh kích thước phù hợp */
	    }
        .password-hint {
	    	font: italic 12px Arial;
	    	color: #777;
	  	}
    </style>
</head>
<body>
    <script>   
    function checkPassword() {
        var password = document.getElementById('editPassword').value;
        // Sử dụng biểu thức chính quy để kiểm tra mật khẩu
        var pattern = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;

        if (!pattern.test(password)) {
            document.getElementById('passwordHint').style.color = 'red';
            return false;
        } else {
            document.getElementById('passwordHint').style.color = '#777';
            return true;
        }
    }
    function Exit2() {
        var username = document.getElementById('editUsername').value;
        var email = document.getElementById('editEmail').value;
        var phoneNumber = document.getElementById('editPhoneNumber').value;
        var password = document.getElementById('editPassword').value;
        var role = document.getElementById('editRole').value;
		var status ;
		 var validPassword = checkPassword();

		    if (!validPassword) {
		        alert('Mật khẩu không đúng định dạng. Mật khẩu phải có ít nhất 8 ký tự, bao gồm cả chữ cái và số.');
		        return;
		    }

        // Kiểm tra nếu có bất kỳ ô nào trống thì hiển thị thông báo
        if (!username || !email || !phoneNumber || !password || !role) {
            alert('Vui lòng điền đầy đủ thông tin.');
            return;
        }
        var url = 'user-management?command=ADD&'+
            '&username=' + encodeURIComponent(username) +
            '&email=' + encodeURIComponent(email) +
            '&phoneNumber=' + encodeURIComponent(phoneNumber) +
            '&password=' + encodeURIComponent(password) +
            '&role=' + encodeURIComponent(role)+
            '&status=unlock' ;
        window.location.href = url;

    }

	</script>
    <div class="form-container">
    	<h1>Nhập thông tin người dùng</h1>
        <form >
            <label for="editUsername">Username:</label>
            <input type="text" id="editUsername" name="username"  />
            <label for="editEmail">Email:</label>
            <input type="text" id="editEmail" name="email"  />
            <label for="editPhoneNumber">Số điện thoại:</label>
            <input type="text" id="editPhoneNumber" name="phoneNumber"  />
            <label for="editPassword">Password:<span class="password-hint" id="passwordHint">
            (Mật khẩu phải có ít nhất 8 ký tự, bao gồm cả chữ cái và số)</span></label>
            <input type="text" id="editPassword" name="password"   />
            
            <label for="editRole">Vai trò:</label>
			<select id="editRole" name="role">
			    <option value="admin" class="role-option">Admin</option>
			    <option value="user" class="role-option">User</option>
			</select>

            <br>
			<input type="button" value="Xác nhận" onclick="Exit2()" />
			<input type="button" value="Hủy" onclick="window.history.back()" />
        </form>
    </div>

</body>
</html>