<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="css/admin.css">
    <title>Create Bill</title>
</head>
<body>
    <h2>Create Bill</h2>

    <!-- Bill Form (Initially Visible) -->
    <div class="cb-container" id="billFormContainer">
        <h3>Generate New Bill</h3>
        <div id="billMessage" class="message"></div>
        <form id="billForm" action="CreateBillServlet" method="post">
            <input type="text" id="billConsumerId" name="billConsumerId" class="cb-input-field" required placeholder="Customer ID"><br>
            <input type="number" id="billUnit" name="billUnit" class="cb-input-field" required placeholder="Unit"><br>
            <input type="number" id="billAmount" name="billAmount" class="cb-input-field" required placeholder="Bill Amount"><br>
            <input type="date" id="billDate" name="billDate" class="cb-input-field" required><br>
            <select id="billStatus" name="billStatus" class="cb-select-field">
                <option value="Unpaid">Unpaid</option>
                <option value="Paid">Paid</option>
            </select><br>
            <button type="submit" class="cb-submit-button">Submit Bill</button>
        </form>
    </div>

    <%-- <!-- Search Section (Initially Hidden) -->
    <div class="cb-search-container" id="searchContainer">
        <input type="text" id="billSearchBar" class="cb-input-field" placeholder="Enter customer name or ID">
        <button id="searchBillButton" class="cb-search-button">Search</button>
        <button onclick="showForm()" class="cb-back-button">Back</button>
    </div>

    <!-- Search Results (Initially Hidden) -->
    <table id="billTable" class="cb-bill-table">
        <thead>
            <tr>
                <th>Customer Name</th>
                <th>ID</th>
                <th>Previous Bill</th>
                <th>Due Date</th>
                <th>Status</th>
                <th>Amount</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody id="billTableBody"></tbody>
    </table> --%>

    <script>
        document.getElementById("billForm").addEventListener("submit", function(event) {
            event.preventDefault();
            let form = event.target;
            let formData = new FormData(form);
            let messageDiv = document.getElementById("billMessage");

            let params = new URLSearchParams(formData).toString();

            fetch(form.action + "?" + params, {
                method: form.method,
            })
            .then(response => {
                if (response.ok) {
                    return response.text().then(text => {
                        messageDiv.className = "message success";
                        messageDiv.textContent = text;
                        messageDiv.style.display = "block";
                    });
                } else {
                    return response.text().then(text => {
                        messageDiv.className = "message error";
                        messageDiv.textContent = text;
                        messageDiv.style.display = "block";
                    });
                }
            })
            .catch(error => {
                messageDiv.className = "message error";
                messageDiv.textContent = "An error occurred: " + error.message;
                messageDiv.style.display = "block";
            });
        });

        function showSearch() {
            document.getElementById("billFormContainer").style.display = "none";
            document.getElementById("searchContainer").style.display = "block";
        }

        function showForm() {
            document.getElementById("billFormContainer").style.display = "block";
            document.getElementById("searchContainer").style.display = "none";
            document.getElementById("billTable").style.display = "none";
        }

        document.getElementById("searchBillButton").addEventListener("click", function() {
            let searchQuery = document.getElementById("billSearchBar").value;
            
            fetch("SearchConsumerForBillServlet?query=" + searchQuery)
                .then(response => response.text())
                .then(data => {
                    console.log(data);
                    document.getElementById("billTableBody").innerHTML = data;
                    document.getElementById("billTable").style.display = "table"; 
                })
                .catch(error => console.error("Error fetching consumer data:", error));
        });

        function setCustomerId(consumerId) {
            document.getElementById("billCustomerId").value = consumerId;
            showForm();
        }
    </script>
</body>
</html>