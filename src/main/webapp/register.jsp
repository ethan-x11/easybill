<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">Registration</h2>
            </div>
            <div class="card-body">
                <div id="message" class="d-none"></div>
                <form id="registerForm" action="RegisterServlet" method="post" onsubmit="return validateForm()">
                    <div class="form-group d-flex flex-column align-items-start">
                        <label for="role" class="text-left">Role:</label>
                        <select id="role" name="role" class="form-control" onchange="toggleForm()">
                            <option value="consumer">Register as Consumer</option>
                            <option value="admin">Register as Admin</option>
                        </select>
                    </div>
                    
                    <div id="consumer-form">
                        <div class="form-group d-flex flex-column align-items-start">
                            <label for="consumerId" class="text-left">Consumer Id:</label>
                            <input type="text" id="consumerId" name="consumerId" class="form-control" pattern="\d{13}" minlength="13" maxlength="13" title="Consumer Id must be exactly 13 digits" required>
                        </div>
                        <div class="form-row">
                            <div class="form-group d-flex flex-column align-items-start col-md-6">
                                <label for="name" class="text-left">Full Name:</label>
                                <input type="text" id="name" name="name" class="form-control" required>
                            </div>
                            <div class="form-group d-flex flex-column align-items-start col-md-6">
                                <label for="email" class="text-left">Email:</label>
                                <input type="email" id="email" name="email" class="form-control" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group d-flex flex-column align-items-start col-md-4">
                                <label for="country_code" class="text-left">Country Code:</label>
                                <select id="country_code" name="country_code" class="form-control" maxlength="10" mainlength="8">
                                    <option value="+1">+1 (USA)</option>
                                    <option value="+91">+91 (India)</option>
                                    <option value="+44">+44 (UK)</option>
                                    <!-- Add more country codes as needed -->
                                </select>
                            </div>
                            <div class="form-group d-flex flex-column align-items-start col-md-8">
                                <label for="mobile_number" class="text-left">Mobile Number:</label>
                                <input type="text" id="mobile_number" name="mobile_number" class="form-control">
                            </div>
                        </div>
                        <div class="form-group d-flex flex-column align-items-start">
                            <label for="userId" class="text-left">User Id:</label>
                            <input type="text" id="userId" name="userId" class="form-control" required>
                        </div>
                    </div>
                    
                    <div id="admin-form" class="d-none">
                        <div class="form-group d-flex flex-column align-items-start">
                            <label for="adminUserId" class="text-left">User Id:</label>
                            <input type="text" id="adminUserId" name="adminUserId" class="form-control">
                        </div>
                        <div class="form-group d-flex flex-column align-items-start">
                            <label for="adminName" class="text-left">Full Name:</label>
                            <input type="text" id="adminName" name="adminName" class="form-control">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group d-flex flex-column align-items-start col-md-6">
                            <label for="password" class="text-left">Password:</label>
                            <input type="password" id="password" name="password" class="form-control" required>
                        </div>
                        <div class="form-group d-flex flex-column align-items-start col-md-6">
                            <label for="confirm_password" class="text-left">Confirm Password:</label>
                            <input type="password" id="confirm_password" name="confirm_password" class="form-control" required>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary">Register</button>
                </form>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        function toggleForm() {
            var role = document.getElementById("role").value;
            var consumerForm = document.getElementById("consumer-form");
            var adminForm = document.getElementById("admin-form");
            var adminUserId = document.getElementById("adminUserId");
            var adminName = document.getElementById("adminName");
            var consumerId = document.getElementById("consumerId");
            var name = document.getElementById("name");

            if (role === "consumer") {
                consumerForm.classList.remove("d-none");
                adminForm.classList.add("d-none");
                adminUserId.removeAttribute("required");
                adminName.removeAttribute("required");
                consumerId.setAttribute("required", "required");
                name.setAttribute("required", "required");
                email.setAttribute("required");
            } else {
                consumerForm.classList.add("d-none");
                adminForm.classList.remove("d-none");
                adminUserId.setAttribute("required", "required");
                adminName.setAttribute("required", "required");
                consumerId.removeAttribute("required");
                name.removeAttribute("required");
                email.removeAttribute("required");
            }
        }

        function validateForm() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirm_password").value;
            if (password !== confirmPassword) {
                document.getElementById("message").classList.remove("d-none");
                document.getElementById("message").classList.add("error");
                document.getElementById("message").innerText = "Passwords do not match.";
                return false;
            }
            return true;
        }

        document.getElementById("registerForm").addEventListener("submit", function(event) {
            event.preventDefault();
            let form = event.target;
            let formData = new FormData(form);
            let messageDiv = document.getElementById("message");

            let params = new URLSearchParams(formData).toString();

            fetch(form.action + "?" + params, {
                method: form.method,
            })
            .then(response => {
                if (response.ok) {
                    messageDiv.classList.remove("d-none", "error");
                    messageDiv.classList.add("success");
                    messageDiv.innerText = "Registration successful!";
                } else if (response.status === 409) { // SC_CONFLICT
                    messageDiv.classList.remove("d-none", "success");
                    messageDiv.classList.add("error");
                    messageDiv.innerText = "Registration failed. User Already Exists";
                } else {
                    response.text().then(data => {
                        messageDiv.classList.remove("d-none", "success");
                        messageDiv.classList.add("error");
                        messageDiv.innerText = "Registration failed. Please try again. ";
                    });
                }
            })
            .catch(error => {
                messageDiv.classList.remove("d-none", "success");
                messageDiv.classList.add("error");
                messageDiv.innerText = "An error occurred. Please try again. ";
            });
        });
    </script>
</body>
</html>