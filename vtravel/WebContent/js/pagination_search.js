var currentPage = 1;
var recordsPerPage = 10; // Số bản ghi mỗi trang
var totalRecords = parseInt(document.getElementById('proposalListSize').getAttribute('data-size'));
var allRows = document.getElementsByClassName('row-item'); // Tất cả các dòng

function searchData(attribute1, attribute2) {
    alert('Ok');
    const input = document.getElementById('searchInput').value.toLowerCase();
    var searchResultRows = [];

    for (let i = 0; i < allRows.length; i++) {
        const att1 = allRows[i].getAttribute(attribute1).toLowerCase();
        const att2 = allRows[i].getAttribute(attribute2).toLowerCase();
        if (att1.includes(input) || att2.includes(input)) {
            searchResultRows.push(allRows[i]);
        }
    }

    // Gọi hàm updateTable để hiển thị kết quả tìm kiếm
    updateTable(searchResultRows);
}

function updateTable(rows) {
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
        recordsPerPage = totalRecords;
    } else {
        recordsPerPage = parseInt(selectedValue);
    }
    currentPage = 1; // Reset về trang đầu tiên khi thay đổi số bản ghi mỗi trang
    updateTable(allRows);
}

function previousPage() {
    if (currentPage > 1) {
        currentPage--;
        updateTable(allRows);
    }
}

function nextPage() {
    var maxPage = Math.ceil(totalRecords / recordsPerPage);
    if (currentPage < maxPage) {
        currentPage++;
        updateTable(allRows);
    }
}

// Khởi tạo bảng khi trang được tải
window.onload = function () {
    updateTable(allRows);
};
