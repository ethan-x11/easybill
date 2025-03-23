// Toggle Sidebar
function toggleSidebar() {
    const sidebar = document.getElementById("sidebar");
    const content = document.getElementById("content");

    if (!sidebar || !content) {
        console.error("Sidebar or content element not found");
        return;
    }

    sidebar.classList.toggle("active");
    content.style.marginLeft = sidebar.classList.contains("active") ? "260px" : "20px";
}

// Load Selected Operation
function loadPage(page) {
    document.querySelectorAll('.operation').forEach(op => op.classList.remove('active'));
    const pageElement = document.getElementById(page);
    if (pageElement) {
        pageElement.classList.add('active');
    } else {
        console.error("Page element not found");
    }
}

// Search Customer
function searchCustomer() {
    const searchQuery = document.getElementById("searchBar").value;
    const filterOption = document.getElementById("filterOptions").value;

    // Simulated Customer Data
    const customers = [
        { name: "Alice Johnson", id: "001", billDate: "2024-03-01", paymentDate: "2024-03-05", status: "Paid", amount: "$100" },
        { name: "Bob Smith", id: "002", billDate: "2024-03-02", paymentDate: "-", status: "Unpaid", amount: "$200" },
        { name: "Charlie Brown", id: "003", billDate: "2024-03-03", paymentDate: "2024-03-07", status: "Paid", amount: "$150" }
    ];

    const filteredCustomers = customers.filter(customer => {
        return (filterOption === "all" || customer.status.toLowerCase() === filterOption) &&
            (searchQuery === "" || customer.name.toLowerCase().includes(searchQuery.toLowerCase()) || customer.id.includes(searchQuery));
    });

    const tableBody = document.getElementById("customerTableBody");
    if (!tableBody) {
        console.error("Customer table body element not found");
        return;
    }
    tableBody.innerHTML = ""; // Clear previous results

    filteredCustomers.forEach(customer => {
        const row = `<tr>
            <td>${customer.name}</td>
            <td>${customer.id}</td>
            <td>${customer.billDate}</td>
            <td>${customer.paymentDate}</td>
            <td>${customer.status}</td>
            <td>${customer.amount}</td>
        </tr>`;
        tableBody.innerHTML += row;
    });

    const customerList = document.getElementById("customerList");
    if (customerList) {
        customerList.style.display = "block";
    } else {
        console.error("Customer list element not found");
    }
}

// Register Customer
document.getElementById("registerForm")?.addEventListener("submit", function(event) {
    event.preventDefault();

    const customerName = document.getElementById("customerName").value;
    const billId = document.getElementById("billId").value;
    const date = document.getElementById("billDate").value;
    const email = document.getElementById("customerEmail").value;
    const password = document.getElementById("customerPassword").value;
    const confirmPassword = document.getElementById("confirmPassword").value;

    if (password !== confirmPassword) {
        alert("Passwords do not match!");
        return;
    }

    const customerId = "CUST" + Math.floor(1000 + Math.random() * 9000);

    const registrationMessage = document.getElementById("registrationMessage");
    if (registrationMessage) {
        registrationMessage.innerHTML = `Customer Registered Successfully! <br> Customer ID: <b>${customerId}</b>`;
    } else {
        console.error("Registration message element not found");
    }
});

// Search Complaints
function searchComplaints() {
    const searchQuery = document.getElementById("complaintsSearchBar").value;

    // Simulated Complaints Data
    const complaints = [
        { name: "Alice Johnson", complaintId: "C001", description: "Slow internet", solution: "Fixed", status: "Resolved" },
        { name: "Bob Smith", complaintId: "C002", description: "Billing issue", solution: "Under review", status: "Pending" },
        { name: "Charlie Brown", complaintId: "C003", description: "Connection drops", solution: "Technician assigned", status: "In Progress" }
    ];

    const filteredComplaints = complaints.filter(complaint => {
        return searchQuery === "" || complaint.name.toLowerCase().includes(searchQuery.toLowerCase()) || complaint.complaintId.includes(searchQuery);
    });

    const tableBody = document.getElementById("complaintsTableBody");
    if (!tableBody) {
        console.error("Complaints table body element not found");
        return;
    }
    tableBody.innerHTML = ""; // Clear previous results

    filteredComplaints.forEach(complaint => {
        const row = `<tr>
            <td>${complaint.name}</td>
            <td>${complaint.complaintId}</td>
            <td>${complaint.description}</td>
            <td>${complaint.solution}</td>
            <td>${complaint.status}</td>
        </tr>`;
        tableBody.innerHTML += row;
    });

    const complaintsList = document.getElementById("complaintsList");
    if (complaintsList) {
        complaintsList.style.display = "block";
    } else {
        console.error("Complaints list element not found");
    }
}

// Search Customer for Bill
function searchCustomerForBill() {
    const searchQuery = document.getElementById("billSearchBar").value;

    // Simulated Customer Data
    const customers = [
        { name: "Alice Johnson", id: "001", amount: "$100", status: "Paid" },
        { name: "Bob Smith", id: "002", amount: "$200", status: "Unpaid" },
        { name: "Charlie Brown", id: "003", amount: "$150", status: "Paid" }
    ];

    const filteredCustomers = customers.filter(customer => {
        return searchQuery === "" || customer.name.toLowerCase().includes(searchQuery.toLowerCase()) || customer.id.includes(searchQuery);
    });

    const tableBody = document.getElementById("billTableBody");
    if (!tableBody) {
        console.error("Bill table body element not found");
        return;
    }
    tableBody.innerHTML = ""; // Clear previous results

    filteredCustomers.forEach(customer => {
        const row = `<tr>
            <td>${customer.name}</td>
            <td>${customer.id}</td>
            <td>${customer.amount}</td>
            <td>${customer.status}</td>
            <td>
                <button onclick="editBill('${customer.id}')">Edit</button>
                <button onclick="markAsPaid('${customer.id}')">Mark Paid</button>
            </td>
        </tr>`;
        tableBody.innerHTML += row;
    });

    const billSection = document.getElementById("billSection");
    if (billSection) {
        billSection.style.display = "block";
    } else {
        console.error("Bill section element not found");
    }
}

// Edit Bill Amount
function editBill(customerId) {
    const newAmount = prompt("Enter new bill amount:");
    if (newAmount) {
        alert(`Bill amount updated for Customer ID: ${customerId} to $${newAmount}`);
    }
}

// Mark as Paid
function markAsPaid(customerId) {
    alert(`Customer ID: ${customerId} marked as PAID.`);
}

// Logout function
function logout() {
    window.location.href = "LogoutServlet";
}