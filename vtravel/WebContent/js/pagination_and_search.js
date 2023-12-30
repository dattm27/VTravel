var currentPage = 1;
var recordsPerPage = 10; // Số bản ghi mỗi trang
var totalRecords = parseInt(document.getElementById('proposalListSize').getAttribute('data-size'));

function searchData(attribute1, attribute2) {
		 
    const input = document.getElementById('searchInput').value;
   	const rows = document.getElementsByClassName('row-item');
    
    for (let i = 0; i < rows.length; i++) {
      const att1 = rows[i].getAttribute(attribute1);
      const att2 = rows[i].getAttribute(attribute2);
       const displayStyle = att1.includes(input) || att2.includes(input) ? '' : 'none';

        // Thiết lập giá trị của thuộc tính style display
        rows[i].style.display = displayStyle;
    }
    // Reset về trang đầu tiên khi thực hiện tìm kiếm
    currentPage = 1;  
   //Cập nhật lại bảng
    updateTable();
  }

  



/*Lọc theo trạng thái các tour custom */
function filterByStatus() {
    var selectedStatus = document.getElementById('Filter').value.toLowerCase();
    const rows = document.querySelectorAll('#InfoBody tr.row-item');
    for (let i = 0; i < rows.length; i++) {
        const statusColumn = rows[i].querySelector('td[id^="status_"]').innerText.toLowerCase();
        const displayStyle = selectedStatus === 'chọn trạng thái' || statusColumn === selectedStatus ? '' : 'none';
        // Thiết lập giá trị của thuộc tính style display
        rows[i].style.display = displayStyle;
    }

    // Reset về trang đầu tiên khi thực hiện lọc
    currentPage = 1;
    // Cập nhật lại bảng
    updateTable();
}


function updateTable() {
    var rows;
    const input = document.getElementById('searchInput').value.toLowerCase();
	 const selectedStatus = document.getElementById('Filter').value.toLowerCase();
    // Kiểm tra xem có đang tìm kiếm hay không
    if (input.trim() === '' &&  selectedStatus === 'chọn trạng thái') {
        // Nếu không tìm kiếm, sử dụng tất cả các dòng
        rows = document.querySelectorAll('#InfoBody tr.row-item');
    } else {
        // Nếu có tìm kiếm, lọc ra các dòng thỏa mãn điều kiện tìm kiếm
        rows = [];
        const allRows = document.querySelectorAll('#InfoBody tr.row-item');
        for (var i = 0; i < allRows.length; i++) {
            const att1 = allRows[i].getAttribute('data-search-1').toLowerCase();
            const att2 = allRows[i].getAttribute('data-search-2').toLowerCase();
            const statusColumn = allRows[i].querySelector('td[id^="status_"]').innerText.toLowerCase();
            
            const isSearchMatch = att1.includes(input) || att2.includes(input);
            const isStatusMatch = selectedStatus === 'chọn trạng thái' || statusColumn === selectedStatus;

            if (isSearchMatch && isStatusMatch) {
               
                rows.push(allRows[i]);
            }
        }
    }

    // Xác định phạm vi bản ghi hiện tại từ danh sách các dòng
    var startIndex = (currentPage - 1) * recordsPerPage;
    var endIndex = recordsPerPage === 'all' ? rows.length : startIndex + recordsPerPage;
    // Hiển thị các bản ghi trong phạm vi
    for (var i = 0; i < rows.length; i++) {
        if (i >= startIndex && i < endIndex) {
            rows[i].style.display = 'table-row';
        } else {
            rows[i].style.display = 'none';
        }
    }

    // Cập nhật trang hiện tại
    document.getElementById('currentPage').innerText = currentPage;
}


function changeRecordsPerPage() {
    var selectedValue = document.getElementById('recordsPerPage').value;
    if (selectedValue === 'all') {
        recordsPerPage =  totalRecords ;
    } else {
        recordsPerPage = parseInt(selectedValue);
    }
    currentPage = 1; // Reset về trang đầu tiên khi thay đổi số bản ghi mỗi trang
    updateTable();
}

function previousPage() {
    if (currentPage > 1) {
        currentPage--;
        updateTable();
    }
}

function nextPage() {
    var maxPage = Math.ceil(totalRecords / recordsPerPage);
    if (currentPage < maxPage) {
        currentPage++;
        updateTable();
    }
}

// Khởi tạo bảng khi trang được tải
window.onload = function () {
    updateTable();
};


