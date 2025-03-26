// Toggle Sidebar
function toggleSidebar() {
    var sidebar = document.getElementById("sidebar");
    var content = document.getElementById("content");
    sidebar.classList.toggle("active");
    if (sidebar.classList.contains("active")) {
        content.style.marginLeft = "280px";
    } else {
        content.style.marginLeft = "40px";
    }
}

// Load Selected Operation
function loadPage(pageId) {
    // Hide all operations
    document.querySelectorAll('.operation').forEach(function (operation) {
        operation.classList.remove('active');
    });

    // Show the selected operation
    document.getElementById(pageId).classList.add('active');

    // Remove active-item class from all sidebar items
    document.querySelectorAll('.sidebar ul li').forEach(function (item) {
        item.classList.remove('active-item');
    });

    // Add active-item class to the selected sidebar item
    document.querySelector(`.sidebar ul li[onclick="loadPage('${pageId}')"]`).classList.add('active-item');
}

function searchConsumers() {
    var query = document.getElementById("searchBar").value;
    var filter = document.getElementById("filterOptions").value;
    var url = "ConsumerListServlet?filter=" + filter + "&query=" + query;

    fetch(url)
        .then(response => response.json())
        .then(data => {
            var consumerTableBody = document.getElementById("consumerTableBody");
            consumerTableBody.innerHTML = "";
            data.forEach(consumer => {
                var row = document.createElement("tr");
                row.innerHTML = `
                    <td>${consumer.consumerId}</td>
                    <td>${consumer.name}</td>
                    <td>${consumer.email}</td>
                    <td>${consumer.countryCode}</td>
                    <td>${consumer.mobileNumber}</td>
                    <td>${consumer.userId}</td>
                    <td>${consumer.latestBillAmount}</td>
                    <td>${consumer.latestBillMonth}</td>
                    <td>${consumer.latestBillDate}</td>
                    <td><button onclick="loadBills(${consumer.consumerId})">Show Bills</button></td>
                `;
                consumerTableBody.appendChild(row);
            });
        })
        .catch(error => console.error('Error:', error));
}

function searchBills() {
    var query = document.getElementById("billSearchBar").value;
    var consumerId = document.getElementById("billConsumerId").value;
    var url = "ConsumerBillServlet?consumerId=" + consumerId + "&query=" + query;

    fetch(url)
        .then(response => response.json())
        .then(data => {
            var billTableBody = document.getElementById("billTableBody");
            billTableBody.innerHTML = "";
            data.forEach(bill => {
                var row = document.createElement("tr");
                row.dataset.billId = bill.billId;
                row.innerHTML = `
                    <td data-field="billId">${bill.billId}</td>
                    <td data-field="billMonth">${bill.month}</td>
                    <td data-field="billDate">${bill.date}</td>
                    <td data-field="amount">${bill.amount}</td>
                    <td data-field="paymentStatus">${bill.paymentStatus}</td>
                    <td><button onclick="editBill(${bill.billId})">Edit</button></td>
                `;
                billTableBody.appendChild(row);
            });
        })
        .catch(error => console.error('Error:', error));
}

function loadBills(consumerId) {
    var url = "ConsumerBillServlet?consumerId=" + consumerId;
    fetch(url)
        .then(response => response.json())
        .then(data => {
            var billTableBody = document.getElementById("billTableBody");
            billTableBody.innerHTML = "";

            var consumerCard = document.getElementById("consumerCard");

            if (!data[0]) {
                consumerCard.innerHTML = `
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Consumer ID: ${consumerId}</h5>
                            <p class="card-text">No Bill Generated</p>
                        </div>
                    </div>
                `;
                consumerCard.style.display = "block";
                document.getElementById("billConsumerId").value = consumerId;
                loadPage('bill');
                return;
            }

            var latestBill = data[0];
            consumerCard.innerHTML = `
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Consumer ID: ${consumerId}</h5>
                        <p class="card-text">Latest Bill Amount: ${latestBill.amount}</p>
                        <p class="card-text">Latest Bill Date: ${latestBill.date}</p>
                        <p class="card-text">Payment Status: ${latestBill.paymentStatus}</p>
                    </div>
                </div>
            `;
            consumerCard.style.display = "block";

            data.forEach(bill => {
                var row = document.createElement("tr");
                row.dataset.billId = bill.billId;
                row.innerHTML = `
                    <td data-field="billId">${bill.billId}</td>
                    <td data-field="billMonth">${bill.month}</td>
                    <td data-field="billDate">${bill.date}</td>
                    <td data-field="billUnit">${bill.unit}</td>
                    <td data-field="amount">${bill.amount}</td>
                    <td data-field="paymentStatus">${bill.paymentStatus}</td>
                    <td><button onclick="editBill('${bill.billId}')">Edit</button></td>
                `;
                billTableBody.appendChild(row);
            });
            document.getElementById("billConsumerId").value = consumerId;
            loadPage('bill');
        })
        .catch(error => console.error('Error:', error));
}

function editBill(billId) {
    var row = document.querySelector(`tr[data-bill-id="${billId}"]`);
    if (!row) {
        console.error(`Row with billId ${billId} not found`);
        return;
    }

    var cells = row.querySelectorAll("td:not(:first-child):not(:last-child)");
    cells.forEach(cell => {
        var field = cell.dataset.field;
        var input;

        if (field === "billMonth") {
            input = document.createElement("select");
            ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"].forEach(month => {
                var option = document.createElement("option");
                option.value = month;
                option.text = month;
                if (cell.innerText === month) {
                    option.selected = true;
                }
                input.appendChild(option);
            });
        } else if (field === "billDate") {
            input = document.createElement("input");
            input.type = "date";
            input.value = cell.innerText;
        } else if (field === "billUnit") {
            input = document.createElement("input");
            input.type = "number";
            input.value = cell.innerText;
        } else if (field === "amount") {
            input = document.createElement("input");
            input.type = "number";
            input.value = cell.innerText;
        } else if (field === "paymentStatus") {
            input = document.createElement("select");
            ["Paid", "Unpaid"].forEach(status => {
                var option = document.createElement("option");
                option.value = status;
                option.text = status;
                if (cell.innerText === status) {
                    option.selected = true;
                }
                input.appendChild(option);
            });
        } else {
            input = document.createElement("input");
            input.value = cell.innerText;
        }

        cell.innerHTML = "";
        cell.appendChild(input);
    });

    var editButton = row.querySelector("button");
    if (!editButton) {
        console.error(`Edit button for billId ${billId} not found`);
        return;
    }

    editButton.innerText = "Save";
    editButton.onclick = function() { saveBill(billId); };
}

function saveBill(billId) {
    var row = document.querySelector(`tr[data-bill-id="${billId}"]`);
    var cells = row.querySelectorAll("td");
    var billData = {};
    cells.forEach(cell => {
        var input = cell.querySelector("input, select");
        if (input) {
            billData[cell.dataset.field] = input.value;
        }
    });

    // Send billData to the server to save the changes
    fetch(`ConsumerBillServlet?billId=${billId}`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(billData)
    }).then(response => {
        var successMessageElement = document.getElementById("billSuccessMessage");
        var errorMessageElement = document.getElementById("billErrorMessage");
        if (response.ok) {
            successMessageElement.style.display = "block";
            errorMessageElement.style.display = "none";
            var consumerId = document.getElementById("billConsumerId").value;
            loadBills(consumerId);
        } else {
            successMessageElement.style.display = "none";
            errorMessageElement.style.display = "block";
            console.error('Error saving bill:', response.statusText);
        }
    }).catch(error => {
        var successMessageElement = document.getElementById("billSuccessMessage");
        var errorMessageElement = document.getElementById("billErrorMessage");
        successMessageElement.style.display = "none";
        errorMessageElement.style.display = "block";
        console.error('Error:', error);
    });
}

function createBill() {
    var consumerId = document.getElementById("billConsumerId").value;
    document.getElementById("billConsumerId").value = consumerId;
    loadPage('createBill');
}

function searchComplaints() {
    var query = document.getElementById("complaintsSearchBar").value;
    var filter = document.getElementById("complaintsFilter").value;
    var url = "ComplaintsManagerServlet?query=" + query + "&filter=" + filter;

    fetch(url)
        .then(response => response.json())
        .then(data => {
            var complaintsTableBody = document.getElementById("complaintsTableBody");
            complaintsTableBody.innerHTML = "";
            data.forEach(complaint => {
                var row = document.createElement("tr");
                row.dataset.complaintId = complaint.complaintId;
                row.innerHTML = `
                    <td>${complaint.complaintId}</td>
                    <td>${complaint.complaintType}</td>
                    <td>${complaint.category}</td>
                    <td>${complaint.contactPerson}</td>
                    <td>${complaint.consumerId}</td>
                    <td>${complaint.mobileNumber}</td>
                    <td>${complaint.complaintDate}</td>
                    <td>${complaint.problemDescription}</td>
                    <td>${complaint.address}</td>
                    <td>${complaint.landmark}</td>
                    <td data-field="status">${complaint.status}</td>
                    <td><button onclick="editComplaint(${complaint.complaintId})">Edit</button></td>
                `;
                complaintsTableBody.appendChild(row);
            });
        })
        .catch(error => console.error('Error:', error));
}

function editComplaint(complaintId) {
    var row = document.querySelector(`tr[data-complaint-id="${complaintId}"]`);
    if (!row) {
        console.error(`Row with complaintId ${complaintId} not found`);
        return;
    }

    var cell = row.querySelector("td[data-field='status']");
    var status = cell.innerText;
    var select = document.createElement("select");
    ["Pending", "Resolved"].forEach(optionValue => {
        var option = document.createElement("option");
        option.value = optionValue;
        option.text = optionValue;
        if (status === optionValue) {
            option.selected = true;
        }
        select.appendChild(option);
    });

    cell.innerHTML = "";
    cell.appendChild(select);

    var editButton = row.querySelector("button");
    if (!editButton) {
        console.error(`Edit button for complaintId ${complaintId} not found`);
        return;
    }

    editButton.innerText = "Save";
    editButton.onclick = function() { saveComplaint(complaintId); };
}

function saveComplaint(complaintId) {
    var row = document.querySelector(`tr[data-complaint-id="${complaintId}"]`);
    var cell = row.querySelector("td[data-field='status']");
    var status = cell.querySelector("select").value;

    var data = new URLSearchParams();
    data.append("complaintId", complaintId);
    data.append("status", status);

    fetch("ComplaintsManagerServlet", {
        method: "POST",
        body: data
    }).then(response => {
        var successMessageElement = document.getElementById("complaintSuccessMessage");
        var errorMessageElement = document.getElementById("complaintErrorMessage");
        if (response.ok) {
            successMessageElement.style.display = "block";
            errorMessageElement.style.display = "none";
            searchComplaints();
        } else {
            successMessageElement.style.display = "none";
            errorMessageElement.style.display = "block";
            console.error('Error saving complaint:', response.statusText);
        }
    }).catch(error => {
        var successMessageElement = document.getElementById("complaintSuccessMessage");
        var errorMessageElement = document.getElementById("complaintErrorMessage");
        successMessageElement.style.display = "none";
        errorMessageElement.style.display = "block";
        console.error('Error:', error);
    });
}

// Load consumers on page load
document.addEventListener("DOMContentLoaded", function() {
    searchConsumers();
    searchComplaints();
});

function confirmLogout(event) {
    event.preventDefault();
    if (confirm("Are you sure you want to logout?")) {
        document.getElementById("logoutForm").submit();
    }
}


