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
function loadPage(page) {
    document.querySelectorAll('.operation').forEach(op => op.classList.remove('active'));
    document.getElementById(page).classList.add('active');
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
    var consumerId = document.getElementById("createBillConsumerId").value;
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
            document.getElementById("createBillConsumerId").value = consumerId;
            loadPage('bill');
        })
        .catch(error => console.error('Error:', error));
}

function editBill(billId) {
    var row = document.querySelector(`tr[data-bill-id="${billId}"]`);
    var cells = row.querySelectorAll("td");
    cells.forEach(cell => {
        var input = document.createElement("input");
        input.value = cell.innerText;
        cell.innerHTML = "";
        cell.appendChild(input);
    });
    var editButton = row.querySelector("button");
    editButton.innerText = "Save";
    editButton.onclick = function() { saveBill(billId); };
}

function saveBill(billId) {
    var row = document.querySelector(`tr[data-bill-id="${billId}"]`);
    var cells = row.querySelectorAll("td");
    var billData = {};
    cells.forEach(cell => {
        var input = cell.querySelector("input");
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
    }).then(response => response.json())
      .then(data => {
          // Update the row with the new data
          cells.forEach(cell => {
              cell.innerHTML = billData[cell.dataset.field];
          });
          var editButton = row.querySelector("button");
          editButton.innerText = "Edit";
          editButton.onclick = function() { editBill(billId); };
      }).catch(error => console.error('Error:', error));
}

function createBill() {
    var consumerId = document.getElementById("createBillConsumerId").value;
    document.getElementById("createBillConsumerId").value = consumerId;
    loadPage('createBill');
}

// Load consumers on page load
document.addEventListener("DOMContentLoaded", function() {
    searchConsumers();
});





