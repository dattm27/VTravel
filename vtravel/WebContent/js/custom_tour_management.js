//Cho admin xác nhận nếu chắc chắc xác nhận thanh toán
function confirmAndPurchase(destination, ordererFullname, proposalID) {
    var confirmMessage = "Bạn có chắc chắn muốn thanh toán tour " + destination + " của " + ordererFullname + "?";
    var confirmPayment = confirm(confirmMessage);

    if (confirmPayment) {
       /* gọi hàm markAsPurchased(proposalID) ở file custom_management_tour.js
       gửi yêu cầu đến servlet để xác nhận thanh toán và thay đổi trạng thái thành đã thanh toán */
    	markAsPurchased(proposalID);
    }
}

//Gửi yêu cầu xác nhận thanh toán đến serlvet và thay đổi cột trạng thái thành đã thanh toán					    
function markAsPurchased(ID) {
    
	var xhr = new XMLHttpRequest();
    xhr.open("POST", "TourControllerServlet", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

    // Điều chỉnh dữ liệu gửi đi bằng cách thêm thuộc tính mới (ví dụ: ID)
    var data = "command=PURCHASED_CUSTOM_TOUR&ID=" + ID;

    xhr.send(data);

    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            console.log(xhr.responseText);
            alert("Đã xác nhận thanh toán thành công");
            // Đặt giá trị mới cho status
			document.getElementById("status_" + ID).innerHTML = "Đã thanh toán";
		
        }
       
    };
	
    
}

// Confirm nếu chắc chắn muốn huỷ
function confirmAndCancel(destination, ordererFullname, ID) {
    var confirmMessage = "Bạn có chắc chắn muốn huỷ yêu cầu đặt chuyến " + destination + " của người dùng " + ordererFullname + " ?";
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
    var data = "command=CANCEL_CUSTOM_TOUR&ID=" + ID;

    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            console.log(xhr.responseText);
            alert("Đã huỷ yêu cầu thành công");
            // Cập nhật cột trạng thái  sau khi huỷ
            document.getElementById("status_" + ID).innerHTML = "Đã huỷ";
      
            
        }
    };

    xhr.send(data);
}
