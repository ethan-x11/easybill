<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Complaint Status</title>
<link rel="stylesheet" type="text/css" href="css/styles.css">

</head>
<%
    if (session != null && session.getAttribute("username") != null) {
        %><%@ include file="fragments/navbarLoggedin.jsp" %><%
    } else {
        %><%@ include file="fragments/navbar.jsp" %><%
    }
%>
<body>
	<div class="comp-top-container">
		<div class="complaint-view-container">
			<h1>Complaint Status View</h1>
			<table>
				<tr>
					<th>Complaint ID</th>
					<th>Complaint date</th>
					<th>Complaint type</th>
					<th>Complaint category</th>
					<th>Description</th>
					<th>Status</th>
				</tr>
			</table>
		</div>
	</div>
</body>

<%@ include file="fragments/footer.jsp"%>
</html>