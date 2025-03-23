<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<title>OTP Verification</title>
<link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>

    <div class="otp_container">
        <h2>Enter OTP for Transaction</h2>

        <form action="FinalPaymentServlet" method="post" class="otp-form">
            <p>
                <strong>Transaction ID:</strong>
                <%=session.getAttribute("transactionId")%></p>
            <p>
                <strong>Date & Time:</strong>
                <%=session.getAttribute("transactionDateTime")%></p>
            <p>
                <strong>Total Payment Amount:</strong>
                $<%=session.getAttribute("totalDue")%></p>

            <div class="otp-box">
                <label>Enter OTP:</label> <input type="text" name="enteredOtp"
                    required pattern="\d{6}" maxlength="6"
                    placeholder="Enter 6-digit OTP">
            </div>
            <br>
            <div class="otp-button">
                <input type="submit" value="Submit OTP"> <a
                    href="payment_result.jsp" class="cancel-btn">Cancel</a>
            </div>
        </form>
    </div>

    <%@ include file="fragments/footer.jsp"%>

</body>
</html>