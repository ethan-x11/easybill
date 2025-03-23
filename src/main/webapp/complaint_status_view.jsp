<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>

<html>

<head>

<title>Complaint Status</title>

</head>

<style>
.container {
	font-family: Arial, sans-serif;
	width: 400px;
	margin: 100px auto;
	background: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	text-align: center;
}

input {
	width: 90%;
	padding: 8px;
	margin: 10px 0;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.buttons {
	display: flex;
	justify-content: center;
	gap: 10px;
}

button {
	padding: 8px 15px;
	border: none;
	cursor: pointer;
	border-radius: 5px;
	color: white;
}

.submit-btn {
	background-color: #71bbb2;
}

.submit-btn:hover {
	background: #497d74;
}

.reset-btn {
	background-color: #dc3545;
}

.reset-btn:hover {
	background: #a71d2a;
}

#complaintDetails {
	margin-top: 15px;
	font-weight: bold;
}
</style>

<body>

	<%@ include file="fragments/navbar.jsp"%>

	<div class="container">

		<h2 style="color: #27445d">Check Complaint Status</h2>
		<br>

		<form action="complaint_status_view.jsp" method="post">

			<label for="complaintId">Complaint Number:</label><br> <input
				type="text" id="complaintId" name="complaintId"
				placeholder="Enter Your Complaint ID" required>

			<div class="buttons">

				<button type="submit" class="submit-btn">Submit</button>

				<button type="button" class="reset-btn"
					onclick="window.location='complaint_status_view.jsp'">Cancel</button>

			</div>

		</form>

		<div id="complaintDetails">

			<%
			String complaintId = request.getParameter("complaintId");

			if (complaintId != null && !complaintId.trim().isEmpty()) {

				Connection conn = null;

				PreparedStatement stmt = null;

				ResultSet rs = null;

				try {

					String url = "jdbc:sqlite:C:\\Users\\subha\\MySQLiteDB";

					Class.forName("org.sqlite.JDBC");
					
					conn = DriverManager.getConnection(url);

					String query = "SELECT * FROM complaint WHERE complaintId = ?";

					stmt = conn.prepareStatement(query);

					stmt.setString(1, complaintId);

					rs = stmt.executeQuery();

					if (rs.next()) {
			%>

			<p>
				<b>Complaint ID:</b>
				<%=rs.getString("complaintId")%></p>

			<p>
				<b>Complaint Type:</b>
				<%=rs.getString("complaint_type")%></p>

			<p>
				<b>Complaint Category:</b>
				<%=rs.getString("category")%></p>

			<p>
				<b>Consumer Number:</b>
				<%=rs.getString("consumer_no")%></p>

			<p>
				<b>Consumer Name:</b>
				<%=rs.getString("contact_person")%></p>

			<p>
				<b>Consumer Address:</b>
				<%=rs.getString("address")%></p>

			<p>
				<b>Consumer Mobile Number:</b>
				<%=rs.getString("mobile_number")%></p>

			<p>
				<b>Complaint Date:</b>
				<%=rs.getString("complaint_date")%></p>

			<p>
				<b>Problem Description:</b>
				<%=rs.getString("problem_description")%></p>

			<%
			} else {

			out.println("<p style='color:red;'>Complaint ID not found.</p>");

			}

			} catch (Exception e) {

			/* out.println("<p style='color:red;'>Error retrieving complaint details.</p>"); */
			out.println(e);

			e.printStackTrace();

			} finally {

			try {

			if (rs != null)
				rs.close();

			if (stmt != null)
				stmt.close();

			if (conn != null)
				conn.close();

			} catch (SQLException ex) {

			ex.printStackTrace();

			}

			}

			}
			%>

		</div>

	</div>

</body>

</html>