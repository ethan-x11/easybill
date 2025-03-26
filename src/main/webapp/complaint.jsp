<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Complaints</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <%@ include file="fragments/navbar.jsp" %>
    <div class="complaint-view-container">
        <h1>Complaints</h1>
        <form action="ViewComplaintsServlet" method="get">
            <input type="text" name="query" placeholder="Search by Consumer Name or ID">
            <select name="statusFilter">
                <option value="">All</option>
                <option value="Pending">Pending</option>
                <option value="Resolved">Resolved</option>
                <option value="Closed">Closed</option>
            </select>
            <button type="submit">Search</button>
        </form>
        <div id="complaintDetails">
            <table>
                <tr>
                    <th>Complaint ID</th>
                    <th>Complaint Date</th>
                    <th>Complaint Type</th>
                    <th>Complaint Category</th>
                    <th>Description</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                <%
                    List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
                    if (complaints != null) {
                        for (Complaint complaint : complaints) {
                %>
                <tr>
                    <td><%= complaint.getComplaintId() %></td>
                    <td><%= complaint.getComplaintDate() %></td>
                    <td><%= complaint.getComplaintType() %></td>
                    <td><%= complaint.getCategory() %></td>
                    <td><%= complaint.getProblemDescription() %></td>
                    <td>
                        <select name="status">
                            <option value="Pending" <%= "Pending".equals(complaint.getStatus()) ? "selected" : "" %>>Pending</option>
                            <option value="Resolved" <%= "Resolved".equals(complaint.getStatus()) ? "selected" : "" %>>Resolved</option>
                            <option value="Closed" <%= "Closed".equals(complaint.getStatus()) ? "selected" : "" %>>Closed</option>
                        </select>
                    </td>
                    <td>
                        <button type="button" onclick="updateStatus(this, <%= complaint.getComplaintId() %>)">Update</button>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
            </table>
        </div>
    </div>
    <%@ include file="fragments/footer.jsp" %>
    <script>
        function updateStatus(button, complaintId) {
            var row = button.closest('tr');
            var status = row.querySelector('select[name="status"]').value;
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "UpdateComplaintStatusServlet", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    button.textContent = "Save";
                }
            };
            xhr.send("complaintId=" + complaintId + "&status=" + status);
        }
    </script>
</body>
</html>