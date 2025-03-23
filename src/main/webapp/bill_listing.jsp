<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="models.Bill" %>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Bill Listing</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <%@ include file="fragments/navbarLoggedin.jsp"%>
    <div class="bill-listing-container">
        <div class="current-bill-card">
            <h2>Current Bill Details</h2>
            <%
                String errorMessage = (String) request.getAttribute("errorMessage");
                List<Bill> bills = (List<Bill>) request.getAttribute("bills");
                if (errorMessage != null) {
            %>
                <p><strong>Error:</strong> <%= errorMessage %></p>
            <%
                } else {
                    double totalDue = 0.0;
                    Bill latestUnpaidBill = null;
                    if (bills != null && !bills.isEmpty()) {
                        for (Bill bill : bills) {
                            if ("Unpaid".equalsIgnoreCase(bill.getPaymentStatus())) {
                                totalDue += bill.getAmount();
                                if (latestUnpaidBill == null) {
                                    latestUnpaidBill = bill;
                                }
                            }
                        }
                        if (latestUnpaidBill != null) {
                            session.setAttribute("currentBill", latestUnpaidBill);
                            session.setAttribute("totalDue", totalDue);
            %>
            <p><strong>Bill ID:</strong> <%= latestUnpaidBill.getBillId() %></p>
            <p><strong>Current Unit Used:</strong> <%= latestUnpaidBill.getUnit() %></p>
            <p><strong>Current Bill Due:</strong> <%= latestUnpaidBill.getAmount() %></p>
            <p><strong>Bill Date:</strong> <%= latestUnpaidBill.getDate() %></p>
            <p><strong>Total Bill Due:</strong> <%= totalDue %></p>
            <p><strong>Due Date:</strong> <%= latestUnpaidBill.getDueDate() %></p>
            <form action="payment.jsp" method="get">
                <input type="hidden" name="billId" value="<%= latestUnpaidBill.getBillId() %>">
                <input type="hidden" name="totalAmount" value="<%= latestUnpaidBill.getAmount() %>">
                <input type="submit" value="Pay Now" class="btn">
            </form>
            <%
                        } else {
            %>
            <p>No Bill Pending</p>
            <%
                        }
                    } else {
            %>
            <p>No Bill Found</p>
            <%
                    }
                }
            %>
        </div>

        <h2>All Bills</h2>
        <table class="bill-table">
            <thead>
                <tr>
                    <th>Bill Unit</th>
                    <th>Month</th>
                    <th>Bill ID</th>
                    <th>Bill Date</th>
                    <th>Due Date</th>
                    <th>Bill Amount</th>
                    <th>Payment Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (bills != null && !bills.isEmpty()) {
                        for (Bill bill : bills) {
                %>
                <tr>
                    <td><%= bill.getUnit() %></td>
                    <td><%= bill.getMonth() %></td>
                    <td><%= bill.getBillId() %></td>
                    <td><%= bill.getDate() %></td>
                    <td><%= bill.getDueDate() %></td>
                    <td><%= bill.getAmount() %></td>
                    <td><%= bill.getPaymentStatus() %></td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
    <%@ include file="fragments/footer.jsp"%>
</body>
</html>