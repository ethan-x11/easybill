<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Panel</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/admin.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="js/admin.js" defer></script>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="#" onclick="toggleSidebar()">&#9776;</a>
                </li>
            </ul>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <span class="nav-link">
                        <%
                            String username = (String) session.getAttribute("username");
                            if (username != null) {
                                out.print(username);
                            } else {
                                out.print("Admin");
                            }
                        %>
                    </span>
                </li>
                <li class="nav-item">
                    <span class="nav-link">admin@admin.com</span>
                </li>
                <li class="nav-item">
                <form id="logoutForm" action="LogoutServlet" method="get">
                    <button class="btn btn-outline-secondary" onclick="confirmLogout(event)">Logout</button>
                </form>
                </li>
            </ul>
        </div>
    </nav>
    
    <div class="d-flex">
        <div class="sidebar bg-light p-3" id="sidebar">
            <button class="btn btn-light mb-3" onclick="toggleSidebar()">&#8592;</button>
            <h3>List of Operations</h3>
            <ul class="list-unstyled">
                <li class="mb-2" onclick="loadPage('home')">Home</li>
                <li class="mb-2" onclick="loadPage('consumers')">Consumers</li>
                <li class="mb-2" onclick="loadPage('register')">Registration</li>
                <li class="mb-2" onclick="loadPage('complaints')">View Complaints</li>
                <li class="mb-2" onclick="loadPage('createBill')">Create Bill</li>
            </ul>
        </div>
        
        <div class="content flex-grow-1 p-3" id="content">
            <div id="home" class="operation active">
                <h2>Welcome to Admin Page</h2>
                <p>Select an operation from the sidebar.</p>
                <div class="text-center">
                    <img src="images/bg-admin.png" alt="Admin Background" style="width: 800px; height: auto;">
                </div>
            </div>
            
            <!-- 1. Search Customer Section -->
            <div id="consumers" class="operation">
                <h2>Customer Search</h2>
                <div id="searchContainer" class="d-flex mb-3">
                    <input type="text" id="searchBar" class="form-control mr-2" placeholder="Search by name or ID" style="width: 400px;">
                    <select id="filterOptions" class="form-control mr-2">
                        <option value="">View All</option>
                        <option value="Paid">Paid</option>
                        <option value="Unpaid">Unpaid</option>
                    </select>
                    <button id="searchButton" class="btn btn-primary" onclick="searchConsumers()">Search</button>
                </div>
                <div id="customerList">
                    <table class="table table-bordered">
                        <thead class="thead-light">
                            <tr>
                                <th>Consumer ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Country Code</th>
                                <th>Mobile Number</th>
                                <th>User ID</th>
                                <th>Latest Bill Amount</th>
                                <th>Bill Month</th>
                                <th>Bill Date</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody id="consumerTableBody">
                            <!-- Consumer rows will be populated here -->
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- 2. Bill Section -->
            <div id="bill" class="operation">
                <!-- Consumer Card -->
                <div id="consumerCard" class="card mb-3" style="display: none;"></div>

                <div id="billSuccessMessage" class="alert alert-success" style="display: none;">Bill Saved Successfully</div>
                <div id="billErrorMessage" class="alert alert-danger" style="display: none;">Error saving bill</div>
                <div id="billListContainer">
                    <div id="billSearchContainer" class="d-flex mb-3">
                        <input type="text" id="billSearchBar" class="form-control mr-2" placeholder="Search by bill ID or month">
                        <button id="billSearchButton" class="btn btn-primary mr-2" onclick="searchBills()">Search</button>
                        <button id="createBillButton" class="btn btn-success" onclick="createBill()">Create Bill</button>
                    </div>
                    <table class="table table-bordered">
                        <thead class="thead-light">
                            <tr>
                                <th>Bill ID</th>
                                <th>Bill Month</th>
                                <th>Bill Date</th>
                                <th>Bill Unit</th>
                                <th>Amount</th>
                                <th>Payment Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody id="billTableBody">
                            <!-- Bill rows will be populated here -->
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- 3. Register Customer Section -->
            <div id="register" class="operation">
                <%@ include file="register.jsp" %>
            </div>

            <!-- 4. View Complaints Section -->
            <div id="complaints" class="operation">
                <%@ include file="complaint.jsp" %>
            </div>

            <!-- 5. Create Bill Section -->
            <div id="createBill" class="operation">
                <%@ include file="createBill.jsp" %>
            </div>

        </div>
    </div>

    <script>
        function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('active');
            document.getElementById('content').classList.toggle('active');
        }
    </script>
</body>
</html>