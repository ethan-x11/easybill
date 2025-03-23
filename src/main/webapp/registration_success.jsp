<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Registration Successful</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <%@ include file="fragments/navbar.jsp" %>
    <div class="registration-success-container">
        <h2>Consumer Registration Successful</h2>
        <p><strong>Customer ID: </strong><%= request.getAttribute("consumerId") %></p>
        <p><strong>User ID: </strong><%= request.getAttribute("userId") %></p>
        <p><strong>Customer Name: </strong><%= request.getAttribute("consumerName") %></p>
        <p><strong>Email: </strong><%= request.getAttribute("email") %></p>
        <button onclick="window.location.href='login.jsp'">Go to Login Page</button>
    </div>
    <%@ include file="fragments/footer.jsp" %>
</body>
</html>