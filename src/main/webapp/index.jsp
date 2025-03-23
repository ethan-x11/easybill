<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    if (session != null) {
        session.invalidate();
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EasyBill</title>
<link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
	<%@ include file="fragments/navbar.jsp"%>
	<div class="home-container">
		<div class="home-inner-container">
			<div class="home-title">
				<h1>
					Welcome to EasyBill <sub> <img
						src="images/bulb.png"
						alt="EasyBill logo" width="20" height="10">
					</sub>
				</h1>
			</div>
			<p>Simple Solution for managing you electric bills.</p>
			<h3>Save Electricity, Save the Future!</h3>
			<p>
				Switch off appliances when not in use, use energy-efficient devices,
				and reduce wastage. <br> A small step today can make a big
				difference tomorrow!
			</p>
			<div class="home-button-container">
				<form action="registration.jsp" style="display: inline;">
					<input type="submit" value="Register" class="home-button">
				</form>
				<form action="login.jsp" style="display: inline;">
					<input type="submit" value="Login" class="home-button">
				</form>
			</div>
		</div>
	</div>
	<%@ include file="fragments/footer.jsp"%>
</body>
</html>