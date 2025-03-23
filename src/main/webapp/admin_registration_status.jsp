<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Registration Status</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <%@ include file="fragments/navbar.jsp" %>
    <div class="registration-success-container">
        <h2>Admin Registration Status</h2>
        <p><%= request.getAttribute("statusMessage") %></p>
        <button onclick="window.location.href='login.jsp'">Go to Login Page</button>
    </div>
    <%@ include file="fragments/footer.jsp" %>
</body>
</html>