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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Complaints</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

    <div class="container mt-5">
        <h2 class="mb-4">View Complaints</h2>
        
        <!-- Search Box -->
        <div id="complaintsSearch" class="form-inline mb-4">
            <input type="text" id="complaintsSearchBar" class="form-control mr-2" placeholder="Search by Consumer ID or Name">
            <select id="complaintsFilter" class="form-control mr-2">
                <option value="">All</option>
                <option value="pending">Pending</option>
                <option value="resolved">Resolved</option>
            </select>
            <button id="complaintsSearchButton" class="btn btn-primary" onclick="searchComplaints()">Search</button>
        </div>

        <!-- Success and Error Messages -->
        <div id="complaintSuccessMessage" class="alert alert-success" style="display: none;">
            Complaint status updated successfully.
        </div>
        <div id="complaintErrorMessage" class="alert alert-danger" style="display: none;">
            Error updating complaint status.
        </div>

        <!-- Complaint Table -->
        <div id="complaintsList" class="table-responsive">
            <table class="table table-bordered">
                <thead class="thead-light">
                    <tr>
                        <th>Complaint ID</th>
                        <th>Type</th>
                        <th>Category</th>
                        <th>Contact Person</th>
                        <th>Consumer ID</th>
                        <th>Mobile Number</th>
                        <th>Date</th>
                        <th>Description</th>
                        <th>Address</th>
                        <th>Landmark</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody id="complaintsTableBody">
                    <!-- Complaints will be loaded here -->
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="js/admin.js"></script>

</body>
</html>