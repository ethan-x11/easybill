<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Complaints</title>
    <link rel="stylesheet" type="text/css" href="css/admin.css">
</head>
<body>

    <div class="com-container">
        <h2>View Complaints</h2>
        
        <!-- Search Box -->
        <div id="complaintsSearch" class="com-search-box">
            <input type="text" id="complaintsSearchBar" class="com-search-bar" placeholder="Enter customer name or ID">
            <button id="complaintsSearchButton" class="com-search-button">Search</button>
        </div>

        <!-- Complaint Table -->
        <div id="complaintsList" class="com-complaints-list">
            <table class="com-complaints-table">
                <thead>
                    <tr>
                        <th>Customer Name</th>
                        <th>Complaint ID</th>
                        <th>Description</th>
                        <th>Solution</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody id="complaintsTableBody">
                    <!-- Fetched complaints will be displayed here -->
                </tbody>
            </table>
        </div>
    </div>

    <script>
        document.getElementById("complaintsSearchButton").addEventListener("click", function () {
            let searchQuery = document.getElementById("complaintsSearchBar").value;

            fetch("ViewComplaintsServlet?query=" + encodeURIComponent(searchQuery))
                .then(response => response.json())
                .then(data => {
                    let tableBody = document.getElementById("complaintsTableBody");
                    tableBody.innerHTML = ""; // Clear previous data

                    data.forEach(complaint => {
                        let row = `<tr>
                            <td>${complaint.name}</td>
                            <td>${complaint.complaintId}</td>
                            <td>${complaint.description}</td>
                            <td>${complaint.solution || "Pending"}</td>
                            <td>${complaint.status}</td>
                        </tr>`;
                        tableBody.innerHTML += row;
                    });
                })
                .catch(error => console.error("Error fetching complaints:", error));
        });
    </script>

</body>
</html>