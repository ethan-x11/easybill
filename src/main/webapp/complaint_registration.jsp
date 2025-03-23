<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Complaint Registration</title>
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
	<div class="fullDiv">
		<div id="complaint_register" class="form-container">
			<h1>Register New Complaint</h1>
			<br> <br>
			<form id="complaintForm" onsubmit="return registerComplaint()">
				<div class="form-grid">
					<div class="form-group">
						<label for="complaint_type">Complaint/Service Type:</label> <select
							id="complaint_type" name="complaint_type"
							onchange="updateCategories()" required>
							<option value="">Select Issue</option>
							<option value="billing">Billing Issue</option>
							<option value="voltage">Voltage Issue</option>
							<option value="disruption">Frequent Disruption Issue</option>
							<option value="street_light">Street Light Issue</option>
							<option value="pole">Electric Pole Issue</option>
							<option value="other">Other</option>
						</select><br> <br>
					</div>

					<div class="form-group">
						<label for="category">Category:</label> <select id="category"
							required>
							<option value="">Select a category</option>
						</select><br> <br>
					</div>

					<div class="form-group">
						<label for="contact_person">Contact Person:</label> <input
							type="text" id="contact_person" name="contact_person"
							placeholder="Enter Name" required><br> <br>
					</div>
					<div class="form-group">
						<label for="consumer_no">Consumer No.:</label> <input type="text"
							id="consumer_no" name="consumer_no" placeholder="Consumer No"
							minlength="13" maxlength="13" pattern="\d{13}" required><br>
						<br>
					</div>

					<div class="form-group">
						<label for="mobile_no">Mobile No.:</label> <input type="text"
							id="mobile_no" name="mobile_no" placeholder="Mobile No"
							minlength="10" maxlength="10" pattern="\d{10}" required><br>
						<br>
					</div>

					<div class="form-group">
						<label for="complaint_date">Date:</label> <input type="date"
							id="complaint_date" name="complaint_date" required><br>
						<br>
					</div>

					<div class="form-group textarea-group">
						<label for="problem_description">Describe Your Problem:</label><br>
						<textarea name="problem_description" id="problem_description"
							rows="5" cols="50" placeholder="Type your problem...." required></textarea>
						<br> <br>
					</div>

					<div class="form-group">
						<label for="address">Address:</label>
						<textarea name="address" id="address" rows="3" cols="50"
							placeholder="Your Address" required></textarea>
						<br> <br>
					</div>

					<div class="form-group">
						<label for="landmark">Landmark:</label> <input type="text"
							id="landmark" name="landmark" placeholder="Landmark" required><br>
						<br>
					</div>

					<div class="button-group">
						<button type="submit">Submit</button>
						<button type="reset" class="cancel-btn" onclick="refreshPage()">Cancel</button>
					</div>
				</div>

			</form>
		</div>
	</div>
	<%@ include file="fragments/footer.jsp"%>

	<script>
            const categoryOptions = {
                billing: [
                    {value:"wrong_charges", text:"Wrong Charges"},
                    {value:"late_bill", text:"Late Bill Delivery"},
                    {value:"refund", text:"Refund"}
                ],

                voltage: [
                    {value:"low_voltage", text:"Low Voltage"},
                    {value:"high_voltage", text:"High Voltage"},
                    {value:"fluctuation", text:"Fluctuation"}
                ],

                disruption: [
                    {value:"power_cut", text:"Power Cut"},
                    {value:"load_shedding", text:"Load Shedding"},
                    {value:"maintenance", text:"Maintenance"}
                ],

                street_light: [
                    {value:"switch", text:"Switch Not Working"},
                    {value:"bulb", text:"Bulb Fuse"},
                    {value:"damaged_light", text:"Damaged Street Light"}
                ],

                pole: [
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
                let complaintId = Math.floor(10000+ Math.random()*9000);

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