<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Registration Failed</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <%@ include file="fragments/navbar.jsp" %>
    <div class="registration-success-container">
        <h2>Consumer Registration Failed</h2>
        <p><%= request.getAttribute("errorMessage") %></p>
        <button onclick="window.location.href='registration.jsp'">Go Back to Registration Page</button>
    </div>
    <%@ include file="fragments/footer.jsp" %>
</body>
</html>