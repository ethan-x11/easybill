<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Panel</title>
<link rel="stylesheet" type="text/css" href="css/admin.css">
<script src="js/admin.js" defer></script>
</head>
<body>
    <nav class="admin-navbar">
        <div class="menu-icon" onclick="toggleSidebar()">&#9776;</div>
        <div class="user-info">
            <span class="user-name">John Doe</span>
            <span class="user-email">johndoe@example.com</span>
            <button class="logout-button" onclick="logout()">Logout</button>
        </div>
    </nav>

    <div class="sidebar" id="sidebar">
        <h3>List of Operations</h3>
        <ul>
            <li onclick="loadPage('home')">Home</li>
            <li onclick="loadPage('search')">Search Customer</li>
            <li onclick="loadPage('register')">Register Customer</li>
            <li onclick="loadPage('complaints')">View Complaints</li>
            <li onclick="loadPage('bill')">Create Bill</li>
        </ul>
    </div>

    <div class="content" id="content">
        <div id="home" class="operation active">
            <h2>Welcome to Home Page</h2>
            <p>Select an operation from the sidebar.</p>
        </div>

        <!-- 1. Search Customer Section -->
        <div id="search" class="operation">
            <h2>Customer Search</h2>
            <div id="searchContainer">
                <input type="text" id="searchBar" placeholder="Enter customer name or ID">
                <select id="filterOptions">
                    <option value="all">View All</option>
                    <option value="paid">Paid</option>
                    <option value="unpaid">Unpaid</option>
                </select>
                <button id="searchButton" onclick="searchCustomer()">Search</button>
            </div>
            <div id="customerList">
                <table>
                    <thead>
                        <tr>
                            <th>Customer Name</th>
                            <th>ID</th>
                            <th>Bill Date</th>
                            <th>Payment Date</th>
                            <th>Status</th>
                            <th>Amount</th>
                        </tr>
                    </thead>
                    <tbody id="customerTableBody"></tbody>
                </table>
            </div>
        </div>

        <!-- 2. Register Customer Section -->
        <div id="register" class="operation">
            <h2>Register Customer</h2>
            <form id="registerForm">
                <label>Customer Name:</label>
                <input type="text" id="customerName" required>
                <label>Bill ID:</label>
                <input type="text" id="billId" required>
                <label>Date:</label>
                <input type="date" id="billDate" required>
                <label>Email:</label>
                <input type="email" id="customerEmail" required>
                <label>Password:</label>
                <input type="password" id="customerPassword" required>
                <label>Confirm Password:</label>
                <input type="password" id="confirmPassword" required>
                <button type="button" onclick="registerCustomer()">Register</button>
            </form>
            <p id="registrationMessage"></p>
        </div>

        <!-- 3. View Complaints Section -->
        <div id="complaints" class="operation">
            <h2>View Complaints</h2>
            <div id="complaintsSearch">
                <input type="text" id="complaintsSearchBar" placeholder="Enter customer name or ID">
                <button id="complaintsSearchButton" onclick="searchComplaints()">Search</button>
            </div>
            <div id="complaintsList">
                <table>
                    <thead>
                        <tr>
                            <th>Customer Name</th>
                            <th>Complaint ID</th>
                            <th>Description</th>
                            <th>Solution</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody id="complaintsTableBody"></tbody>
                </table>
            </div>
        </div>

        <!-- 4. Create Bill Section -->
        <div id="bill" class="operation">
            <h2>Create Bill</h2>
            <div id="billSearchContainer">
                <input type="text" id="billSearchBar" placeholder="Enter customer name or ID">
                <button id="searchBillButton" onclick="searchCustomerForBill()">Search</button>
            </div>
            <div id="billSection">
                <table>
                    <thead>
                        <tr>
                            <th>Customer Name</th>
                            <th>ID</th>
                            <th>Previous Bill</th>
                            <th>Due Date</th>
                            <th>Status</th>
                            <th>Amount</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody id="billTableBody"></tbody>
                </table>
                <form id="billForm">
                    <h3>Generate New Bill</h3>
                    <label>Customer ID:</label>
                    <input type="text" id="billCustomerId" readonly>
                    <label>Bill Amount:</label>
                    <input type="number" id="billAmount" required>
                    <label>Due Date:</label>
                    <input type="date" id="billDueDate" required>
                    <label>Status:</label>
                    <select id="billStatus">
                        <option value="unpaid">Unpaid</option>
                        <option value="paid">Paid</option>
                    </select>
                    <button type="button" onclick="createBill()">Submit Bill</button>
                </form>
                <p id="billMessage"></p>
            </div>
        </div>
    </div>
</body>
</html>