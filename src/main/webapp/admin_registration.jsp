<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Admin Registration</title>
<script src="js/registration.js" defer></script>
<link rel="stylesheet" type="text/css" href="css/styles.css">
<script>
function validateForm() {
    var password = document.getElementById("password").value;
    var confirmPassword = document.getElementById("confirmPassword").value;
    if (password !== confirmPassword) {
        document.getElementById("error-message").innerText = "Passwords do not match.";
        return false;
    }
    return true;
}
</script>
</head>
<body>
    <%@ include file="fragments/navbar.jsp"%>
    <div class="reg-container">
        <h2 class="reg-title">Admin Registration</h2>
        <div id="error-message" class="error-message"></div>
        <form action="AdminRegistrationHandlerServlet" method="post" class="reg-form" onsubmit="return validateForm()">
            <label for="adminId" class="reg-label">Admin Id:</label>
            <input type="text" id="adminId" name="adminId" class="reg-input" required>
            <label for="adminName" class="reg-label">Admin Name:</label>
            <input type="text" id="adminName" name="adminName" class="reg-input" required>
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