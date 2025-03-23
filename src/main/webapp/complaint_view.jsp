<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="models.Complaint" %>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Complaint Status</title>
<link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<%
    if (session != null && session.getAttribute("username") != null) {
        %><%@ include file="fragments/navbarLoggedin.jsp" %><%
    } else {
        %><%@ include file="fragments/navbar.jsp" %><%
    }
%>
<body>
    <div class="comp-top-container">
        <div class="complaint-view-container">
            <h1>Complaint Status View</h1>
            <%
                String message = (String) request.getAttribute("message");
                if (message != null) {
            %>
                <p><%= message %></p>
            <%
                } else {
            %>
            <table>
                <tr>
                    <th>Complaint ID</th>
                    <th>Complaint Date</th>
                    <th>Complaint Type</th>
                    <th>Complaint Category</th>
                    <th>Description</th>
                    <th>Status</th>
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
                    <td><%= complaint.getStatus() %></td>
                </tr>
                <%
                        }
                    }
                %>
            </table>
            <%
                }
            %>
        </div>
    </div>
</body>
<%@ include file="fragments/footer.jsp"%>
</html>