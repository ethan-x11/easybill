<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*, java.util.Random"%>



<html>

<head>

<title>Complaint Registration</title>

<style>
.fullDiv {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	display: flex;
	flex-direction: column;
	align-items: center;
	margin: 0;
	padding: 0;
}

.form-container {
	width: 50%;
	min-width: 20px;
	padding: 20px;
	margin: 40px;
	background: #fff;
	border: 2px solid #27445d;
	border-radius: 10px;
	box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.1);
}

h1 {
	text-align: center;
	color: #27445d;
}

.form-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
}

.form-group {
	display: flex;
	flex-direction: column;
}

label {
	font-weight: bold;
	margin-top: 10px;
}

input, select, textarea {
	width: 100%;
	padding: 8px;
	margin-top: 5px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 14px;
}

.textarea-group {
	grid-column: span 2;
}

.button-group {
	display: flex;
	justify-content: center;
	gap: 10px;
	grid-column: span 2;
	margin-top: 15px;
}

button {
	width: 100%;
	padding: 10px;
	background: #71bbb2;
	color: white;
	border: none;
	border-radius: 5px;
	font-size: 16px;
	cursor: pointer;
}

button:hover {
	background: #0056b3;
}

.cancel-btn {
	background: #dc3545;
}

.cancel-btn:hover {
	background: #a71d2a;
}
</style>

</head>

<body>

	<%@ include file="fragments/navbar.jsp"%>

	<div class="fullDiv">

		<div id="complaint_register" class="form-container">

			<h1>Register New Complaint</h1>
			<br> <br>



			<%-- Generate a unique complaint ID --%>

			<%
			Random random = new Random();

			int complaintId = 10000 + random.nextInt(900000);
			%>



			<%-- Handle form submission --%>

			<%
			if (request.getMethod().equalsIgnoreCase("POST")) {

				String url = "jdbc:sqlite:C:\\Users\\subha\\MySQLiteDB";

				String complaintType = request.getParameter("complaint_type");

				String category = request.getParameter("category");

				String contactPerson = request.getParameter("contact_person");

				String consumerNo = request.getParameter("consumer_no");

				String mobileNo = request.getParameter("mobile_no");

				String complaintDate = request.getParameter("complaint_date");

				String problemDescription = request.getParameter("problem_description");

				String address = request.getParameter("address");

				String landmark = request.getParameter("landmark");

				Connection conn = null;

				PreparedStatement pstmt = null;

				Statement stmt = null;

				try {

					Class.forName("org.sqlite.JDBC");

					conn = DriverManager.getConnection(url);

					stmt = conn.createStatement();

					String sql = "INSERT INTO complaint (complaintId, complaint_type, category, contact_person, consumer_no, mobile_number, complaint_date, problem_description, address, landmark) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

					pstmt = conn.prepareStatement(sql);

					pstmt.setInt(1, complaintId);

					pstmt.setString(2, complaintType);

					pstmt.setString(3, category);

					pstmt.setString(4, contactPerson);

					pstmt.setString(5, consumerNo);

					pstmt.setString(6, mobileNo);

					pstmt.setString(7, complaintDate);

					pstmt.setString(8, problemDescription);

					pstmt.setString(9, address);

					pstmt.setString(10, landmark);

					int rowsInserted = pstmt.executeUpdate();

					if (rowsInserted > 0) {
			%>

			<script>

alert("Complaint Registered Successfully! Your Complaint ID is <%=complaintId%>");

window.location.href = "register_complaint.jsp";

</script>

			<%
			} else {
			%>

			<script>

alert("Error registering complaint. Please try again.");

</script>

			<%
			}

			} catch (Exception e) {

			out.println("Database Error: " + e.getMessage());

			} finally {

			if (pstmt != null)
			pstmt.close();

			if (conn != null)
			conn.close();

			}

			}
			%>



			<form id="complaintForm" method="post">

				<input type="hidden" name="complaintId" value="<%=complaintId%>">



				<div class="form-grid">

					<div class="form-group">

						<label for="complaint_type">Complaint/Service Type:</label> <select
							id="complaint_type" name="complaint_type"
							onchange="updateCategories()" required>

							<option value="">Select Issue</option>

							<option value="billing_issue">Billing Issue</option>

							<option value="voltage_issue">Voltage Issue</option>

							<option value="disruption_issue">Frequent Disruption
								Issue</option>

							<option value="street_light_issue">Street Light Issue</option>

							<option value="pole_issue">Electric Pole Issue</option>

							<option value="other">Other</option>

						</select>

					</div>



					<div class="form-group">

						<label for="category">Category:</label> <select id="category"
							name="category" required>

							<option value="">Select a category</option>

						</select>

					</div>



					<div class="form-group">

						<label for="contact_person">Contact Person:</label> <input
							type="text" id="contact_person" name="contact_person" required>

					</div>



					<div class="form-group">

						<label for="consumer_no">Consumer No.:</label> <input type="text"
							id="consumer_no" name="consumer_no" required>

					</div>



					<div class="form-group">

						<label for="mobile_no">Mobile No.:</label> <input type="text"
							id="mobile_no" name="mobile_no" required>

					</div>



					<div class="form-group">

						<label for="complaint_date">Date:</label> <input type="date"
							id="complaint_date" name="complaint_date" required>

					</div>



					<div class="form-group textarea-group">

						<label for="problem_description">Describe Your Problem:</label>

						<textarea id="problem_description" name="problem_description"
							required></textarea>

					</div>



					<div class="form-group">

						<label for="address">Address:</label>

						<textarea id="address" name="address" required></textarea>

					</div>



					<div class="form-group">

						<label for="landmark">Landmark:</label> <input type="text"
							id="landmark" name="landmark" required>

					</div>

				</div>



				<div class="button-group">

					<button type="submit">Submit</button>

					<button type="reset" class="cancel-btn">Cancel</button>

				</div>

			</form>

		</div>

	</div>



	<script>

const categoryOptions = {

billing_issue: [

{value:"wrong_charges", text:"Wrong Charges"},

{value:"late_bill", text:"Late Bill Delivery"},

{value:"refund", text:"Refund"}

],



voltage_issue: [

{value:"low_voltage", text:"Low Voltage"},

{value:"high_voltage", text:"High Voltage"},

{value:"fluctuation", text:"Fluctuation"}

],



disruption_issue: [

{value:"power_cut", text:"Power Cut"},

{value:"load_shedding", text:"Load Shedding"},

{value:"maintenance", text:"Maintenance"}

],



street_light_issue: [

{value:"switch", text:"Switch Not Working"},

{value:"bulb", text:"Bulb Fuse"},

{value:"damaged_light", text:"Damaged Street Light"}

],



pole_issue: [

{value:"damaged_pole", text:"Damaged/Leaning Pole"},

{value:"exposed_wire", text:"Exposed Wires"},

{value:"sparking", text:"Sparking"},

{value:"hanging_wires", text:"Hanging Wires"}

],



other: [

{value:"other", text:"Other"}

]

};



function updateCategories() {

const complaint_type = document.getElementById("complaint_type").value;

const categoryDropdown = document.getElementById("category");



categoryDropdown.innerHTML = '<option value="">Select a category</option>';

if(complaint_type && categoryOptions[complaint_type]) {

categoryOptions[complaint_type].forEach(category => {

const option = document.createElement("option");

option.value = category.value;

option.textContent = category.text;

categoryDropdown.appendChild(option);

});

}



}



function registerComplaint(){



alert("Complaint Registration Successful.\nYour Complaint ID is: "+complaintId);



document.getElementById("complaintForm").reset();



return false;

}



function refreshPage(){

location.reload();

}



</script>

</body>

</html>