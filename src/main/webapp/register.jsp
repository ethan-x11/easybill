<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
        }
        form {
            background: white;
            
            padding: 20px;
            border-radius: 8px;
            width: 300px;
            margin: auto;
            box-shadow: 0px 0px 10px gray;
        }
        input, select {
            width: 90%;
            padding: 8px;
            margin: 5px 0;
        }
        button {
            background-color: blue;
            color: white;
            padding: 10px;
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="reg-container">
        <h2 class="reg-title">Registration</h2>
        <div id="error-message" class="error-message"></div>
        <%
            String successMessage = (String) request.getAttribute("successMessage");
            if (successMessage != null) {
        %>
            <div class="success-message"><%= successMessage %></div>
        <%
            }
        %>
        <form action="${pageContext.request.contextPath}/RegisterServlet" method="post" class="reg-form" onsubmit="return validateForm()">
            <label for="consumerId" class="reg-label">Consumer Id:</label>
            <input type="text" id="consumerId" name="consumerId" class="reg-input" pattern="\d{13}" title="Consumer Id must be exactly 13 digits" required>
            <label for="name" class="reg-label">Full Name:</label>
            <input type="text" id="name" name="name" class="reg-input" required>
            <label for="email" class="reg-label">Email:</label>
            <input type="email" id="email" name="email" class="reg-input" required>
            <label for="country_code" class="reg-label">Country Code:</label>
            <input type="text" id="country_code" name="country_code" class="reg-input">
            <label for="mobile_number" class="reg-label">Mobile Number:</label>
            <input type="text" id="mobile_number" name="mobile_number" class="reg-input">
            <label for="userId" class="reg-label">Username:</label>
            <input type="text" id="userId" name="userId" class="reg-input" required>
            <label for="role" class="reg-label">Role:</label>
            <select id="role" name="role" class="reg-input">
                <option value="user">Register as User</option>
                <option value="admin">Register as Admin</option>
            </select>
            <label for="password" class="reg-label">Password (for admin only):</label>
            <input type="password" id="password" name="password" class="reg-input">
            <button type="submit" class="reg-button">Register</button>
        </form>
    </div>
</body>
</html>