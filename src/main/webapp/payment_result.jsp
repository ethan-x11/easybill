<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Status</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>

<div class="result_container">
    <% 
        String status = request.getParameter("status");

        if ("success".equals(status)) { 
    %>
        <div class="success-box">
            <h2>Payment Successful!</h2>
            <p><strong>Transaction ID:</strong> <%= session.getAttribute("transactionId") %></p>
            <p>Thank you for your payment.</p>
            <a href="BillListServlet" class="btn">Go to Home</a>
        </div>
    <% 
        } else { 
    %>
        <div class="error-box">
            <h2>Payment Failed!</h2>
            <p>Your payment could not be processed. Please try again.</p>
            <a href="payment.jsp" class="btn error-btn">Try Again</a>
        </div>
    <% 
        } 
    %>
</div>

<%@ include file="fragments/footer.jsp" %>

</body>
</html>