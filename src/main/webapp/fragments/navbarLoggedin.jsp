<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>

<%
HttpSession sessionObj = request.getSession(false);
String username = (sessionObj != null) ? (String) sessionObj.getAttribute("username") : "Guest";
String consumerId = (sessionObj != null) ? String.valueOf(sessionObj.getAttribute("consumerId")) : "N/A";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="./../css/styles.css">
<script src="js/navbar.js" defer></script>
<script>
    function confirmLogout(event) {
        event.preventDefault();
        if (confirm("Are you sure you want to logout?")) {
            document.getElementById("logoutForm").submit();
        }
    }
</script>
</head>
<body>

    <nav class="navbarLoggedin">
        <div class="nav-containerLoggedin">
            <ul class="nav-linksLoggedin">
                <li><a href="BillListServlet">Pay Bill</a></li>
                <li><a href="complaint_registration.jsp">Register Complaint</a></li>
                <li><a href="ComplaintSearchServlet">Complaint Status</a></li>
            </ul>
        </div>

        <div class="user-sectionLoggedin">
            <div class="user-iconLoggedin" onclick="toggleUserInfo()">👤</div>

            <div class="user-infoLoggedin" id="userInfo">
                <p>
                    <strong>User ID:</strong>
                    <%=username%></p>
                <p>
                    <strong>Consumer ID:</strong>
                    <%=consumerId%></p>
            </div>

            <form id="logoutForm" action="LogoutServlet" method="get">
                <button type="submit" class="logout-buttonLoggedin" onclick="confirmLogout(event)">Logout</button>
            </form>
        </div>
    </nav>

</body>
</html>