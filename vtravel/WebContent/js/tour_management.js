// Confirm nếu chắc chắn muốn huỷ
function confirmAndDelete( ID) {
    var confirmMessage = "Bạn có chắc chắn muốn xoá chuyến ?";
    var userConfirmed = confirm(confirmMessage);

    if (userConfirmed) {
        // Gọi hàm markAsCancelled khi admin đã xác nhận
        markAsCancelled(ID);
    }
}

function markAsCancelled(ID) {
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "TourControllerServlet", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

    // Điều chỉnh dữ liệu gửi đi bằng cách thêm thuộc tính mới (ví dụ: ID)
    var data = "command=DELETE_A_TOUR&ID=" + ID;

    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            console.log(xhr.responseText);
            alert("Đã xoá thành công");
            // Cập nhật cột trạng thái  sau khi huỷ
            document.getElementById("ID_" + ID).style.display = "none";
      
            
        }
    };

    xhr.send(data);
}