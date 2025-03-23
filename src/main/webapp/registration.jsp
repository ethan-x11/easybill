<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%
    if (session != null && session.getAttribute("username") != null) {
        response.sendRedirect("BillListServlet");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<title>Consumer Registration</title>
<script src="js/registration.js" defer></script>
<link rel="stylesheet" type="text/css" href="css/styles.css">
<script>
function validateForm() {
    var password = document.getElementById("password").value;
    var confirmPassword = document.getElementById("confirmPassword").value;
    var consumerId = document.getElementById("consumerId").value;
    
    if (password !== confirmPassword) {
        document.getElementById("error-message").innerText = "Passwords do not match.";
        return false;
    }
    
    if (!/^\d{13}$/.test(consumerId)) {
        document.getElementById("error-message").innerText = "Consumer Id must be exactly 13 digits.";
        return false;
    }
    
    return true;
}
</script>
</head>
<body>
    <%@ include file="fragments/navbar.jsp"%>
    <div class="reg-container">
        <h2 class="reg-title">Consumer Registration</h2>
        <div id="error-message" class="error-message"></div>
        <form action="RegistrationHandlerServlet" method="post" class="reg-form" onsubmit="return validateForm()">
            <label for="consumerId" class="reg-label">Consumer Id:</label>
            <input type="text" id="consumerId" name="consumerId" class="reg-input" pattern="\d{13}" title="Consumer Id must be exactly 13 digits" required>
            <label for="consumerName" class="reg-label">Consumer Name:</label>
            <input type="text" id="consumerName" name="consumerName" class="reg-input" maxlength="50" required>
            <label for="email" class="reg-label">Email:</label>
            <input type="email" id="email" name="email" class="reg-input" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" title="Please enter a valid email address" required>
            <label for="countryCode" class="reg-label">Country Code:</label>
            <select id="countryCode" name="countryCode" class="reg-select">
                <option value="+1">+1 (USA)</option>
                <option value="+91" selected>+91 (India)</option>
                <option value="+44">+44 (UK)</option>
                <option value="+81">+81 (Japan)</option>
                <option value="+61">+61 (Australia)</option>
            </select>
            <label for="mobileNumber" class="reg-label">Mobile Number:</label>
            <input type="text" id="mobileNumber" name="mobileNumber" class="reg-input" minlength="10" maxlength="10" placeholder="Enter 10-digit mobile number" required>
            <label for="userId" class="reg-label">User Id:</label>
            <input type="text" id="userId" name="userId" class="reg-input" minlength="5" maxlength="20" required>
            <label for="password" class="reg-label">Password:</label>
            <input type="password" id="password" name="password" class="reg-input" required>
            <label for="confirmPassword" class="reg-label">Confirm Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" class="reg-input" required>
            <button type="submit" class="reg-button">Register</button>
        </form>
    </div>
    <%@ include file="fragments/footer.jsp"%>
</body>
</html>