<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Complaint Status</title>
<link rel="stylesheet" type="text/css" href="css/styles.css">
</head>

<body>
	<%@ include file="fragments/navbar.jsp"%>
	<div class="complaint-search-container">
		<h2>Check Complaint Status</h2>
		<br> <label for="complaintId">Complaint Number:</label><br>
		<input type="text" id="complaintId"
			placeholder="Enter Your Complaint ID" required>
		<div class="buttons">
			<button class="submit-btn" onclick="fetchComplaint()">Submit</button>
			<button class="reset-btn" onclick="resetForm()">Cancel</button>
		</div>
		<div id="complaintDetails"></div>
	</div>
	<%@ include file="fragments/footer.jsp"%>
	<script>
            function fetchComplaint(){
                const complaintId = document.getElementById("complaintId").value;
                const detailsDiv = document.getElementById("complaintDetails");

                if(complaintId === '12345'){
                    detailsDiv.innerHTML = `
                        <p>Complaint ID: 12345</p>
                        <p>Complaint Type: Voltage related</p>
                        <p>Complaint Category: Fluctuation</p>
                        <p>Stauts: Resolved</p>
                        <p>Details: Issue has been fixed and resolved.</p>
                    `;
                }
                
                else if(complaintId === '57678'){
                    detailsDiv.innerHTML = `
                        <p>Complaint ID: 57678</p>
                        <p>Complaint Type: Billing related</p>
                        <p>Complaint Category: Late Bill Delivery</p>
                        <p>Stauts: Pending</p>
                        <p>Details: Issue has been registered.</p>
                        ` ;                  
                }
                
                else{
                    detailsDiv.innerHTML = `
                        <p>Complaint ID not found.</p>
                        `;
                }
            }

            function resetForm(){
                document.getElementById("complaintId").value = "";
                document.getElementById("complaintDetails").innerHTML = "";
            }
        </script>
        <%@ include file="fragments/footer.jsp"%>
</body>
</html>