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
        <form >
            <label for="editUserId">User ID:</label>
            <input type="text" id="editUserId" name="userId" value="${param.userId}" readonly="readonly" />
            <label for="editUsername">Username:</label>
            <input type="text" id="editUsername" name="username" value="${accountUP.username}" />
            <label for="editEmail">Email:</label>
            <input type="text" id="editEmail" name="email" value="${accountUP.email}" readonly="readonly" />
            <label for="editPhoneNumber">Số điện thoại:</label>
            <input type="text" id="editPhoneNumber" name="phoneNumber" value="${accountUP.phoneNumber}" readonly="readonly" />
            <label for="editPassword">Password:</label>
            <input type="text" id="editPassword" name="password" value="${accountUP.password}"readonly="readonly"  />
            <label for="editRole">Vai trò:</label>
            <input type="text" id="editRole" name="role" value="${accountUP.role}"readonly="readonly" />
            <label for="editStatus">Trạng thái:</label>
            <input type="text" id="editStatus" name= "status" value="${accountUP.status}" />
			<input type="button" value="Quay lại" onclick="window.history.back()" />
        </form>
    </div>
    
</body>
</html>
