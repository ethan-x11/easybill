<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="models.Complaint" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Complaint Status</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <%@ include file="fragments/navbar.jsp" %>
    <div class="complaint-search-container">
        <h2>Check Complaint Status</h2>
        <form action="ComplaintSearchServlet" method="post">
            <label for="complaintId">Complaint Number:</label><br>
            <input type="text" id="complaintId" name="complaintId" placeholder="Enter Your Complaint ID" required>
            <div class="buttons">
                <button type="submit" class="submit-btn">Submit</button>
                <button type="reset" class="reset-btn">Cancel</button>
            </div>
        </form>
        <div id="complaintDetails">
            <%
                Complaint complaint = (Complaint) request.getAttribute("complaint");
                if (complaint != null) {
            %>
                <p><b>Complaint ID:</b> <%= complaint.getComplaintId() %></p>
                <p><b>Complaint Type:</b> <%= complaint.getComplaintType() %></p>
                <p><b>Complaint Category:</b> <%= complaint.getCategory() %></p>
                <p><b>Consumer Number:</b> <%= complaint.getConsumerId() %></p>
                <p><b>Consumer Name:</b> <%= complaint.getContactPerson() %></p>
                <p><b>Consumer Address:</b> <%= complaint.getAddress() %></p>
                <p><b>Consumer Mobile Number:</b> <%= complaint.getMobileNumber() %></p>
                <p><b>Complaint Date:</b> <%= complaint.getComplaintDate() %></p>
                <p><b>Problem Description:</b> <%= complaint.getProblemDescription() %></p>
            <%
                } else {
                    String errorMessage = (String) request.getAttribute("errorMessage");
                    if (errorMessage != null) {
                        out.println("<p style='color:red;'>" + errorMessage + "</p>");
                    }
                }
            %>
        </div>
    </div>
    <%@ include file="fragments/footer.jsp" %>
</body>
</html>