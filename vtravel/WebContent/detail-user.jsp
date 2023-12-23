<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa thông tin người dùng</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="card mx-auto" style="max-width: 400px;">
            <div class="card-header bg-primary text-white">
                <h1 class="h3 mb-0">Thông tin người dùng</h1>
            </div>
            <div class="card-body">
                <form>
                    <div class="form-group">
                        <label for="editUserId">User ID:</label>
                        <input type="text" id="editUserId" name="userId" class="form-control" value="${accountUP.id}" readonly="readonly" />
                    </div>
                    <div class="form-group">
                        <label for="editFullname">Fullname:</label>
                        <input type="text" id="editFullname" name="fullname" class="form-control" value="${accountUP.fullname}" readonly="readonly" />
                    </div>
                    <div class="form-group">
                        <label for="editUsername">Username:</label>
                        <input type="text" id="editUsername" name="username" class="form-control" value="${accountUP.username}" readonly="readonly" />
                    </div>
                    <div class="form-group">
                        <label for="editEmail">Email:</label>
                        <input type="text" id="editEmail" name="email" class="form-control" value="${accountUP.email}" readonly="readonly" />
                    </div>
                    <div class="form-group">
                        <label for="editPhoneNumber">Số điện thoại:</label>
                        <input type="text" id="editPhoneNumber" name="phoneNumber" class="form-control" value="${accountUP.phone_number}" readonly="readonly" />
                    </div>
                    <div class="form-group">
                        <label for="editPassword">Password:</label>
                        <input type="text" id="editPassword" name="password" class="form-control" value="${accountUP.password}" readonly="readonly" />
                    </div>
                    <div class="form-group">
                        <label for="editRole">Vai trò:</label>
                        <input type="text" id="editRole" name="role" class="form-control" value="${accountUP.role}" readonly="readonly" />
                    </div>
                    <div class="form-group">
                        <label for="editStatus">Trạng thái:</label>
                        <input type="text" id="editStatus" name="status" class="form-control" value="${accountUP.status}" readonly="readonly" />
                    </div>
                    <button type="button" class="btn btn-primary" onclick="closePopup()">Thoát</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS (optional) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
     <script>
        function closePopup() {
            // Đóng pop-up
            window.parent.hidePopup();
        }
    </script>
</body>
</html>
