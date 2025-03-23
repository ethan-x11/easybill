<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.time.LocalDateTime, java.time.format.DateTimeFormatter"%>
<%
    if (session == null || session.getAttribute("username") == null || session.getAttribute("transactionId") == null || session.getAttribute("transactionDateTime") == null) {
        response.sendRedirect("BillListServlet");
        return;
    }

    String paymentFlag = (String) session.getAttribute("paymentFlag");
    if (paymentFlag == null || paymentFlag.equalsIgnoreCase("false")) {
        response.sendRedirect("BillListServlet"); 
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<title>Enter Card Details</title>
<link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>


	<div class="card-container">
		<h2>Enter Your Card Details</h2>

		<form class="payment_form" action="OtpProcessingServlet" method="post">
			<label>Payment Type:</label> <strong><%=request.getParameter("paymentMethod").toUpperCase()%></strong>
			<br> <br>
			<div class="card-data">
				<div class="card-data-input-box">
					<label>Card Number:</label> <input type="text" name="cardNumber"
						required pattern="\d{16}" maxlength="16"
						placeholder="Enter 16-digit card number">
				</div>
				<br>

				<div class="card-data-input-box">
					<label>Expiry Date:</label> <input type="month" name="expiryDate"
						required>
				</div>
				<br>
				<div class="card-data-input-box">
					<label>CVV:</label> <input type="password" name="cvv" required
						pattern="\d{3}" maxlength="3" placeholder="CVV">
				</div>
				<br>

				<div class="card-data-input-box">
					<label>Cardholder Name:</label> <input type="text"
						name="cardHolderName" required placeholder="Enter name as on card">
				</div>
			</div>
			<br>

						<%
			String transactionId = (String) session.getAttribute("transactionId");
			String transactionDateTime = (String) session.getAttribute("transactionDateTime");
			%>

			<input type="hidden" name="transactionId" value="<%=transactionId%>">
			<input type="hidden" name="transactionDateTime"
				value="<%=transactionDateTime%>"> <input type="hidden"
				name="paymentMethod"
				value="<%=request.getParameter("paymentMethod")%>"> <input
				type="submit" value="Proceed to OTP" class="card-data-input">
			<a href="BillListServlet" class="btn cancel-btn">Cancel</a>
		</form>
	</div>

	<%@ include file="fragments/footer.jsp"%>

</body>
</html>