<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="models.Consumer" %>
<%@ page import="models.Bill" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Easybills</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <%@ include file="fragments/navbarLoggedin.jsp"%>
    <div class="payment-container">
        <h2 class="payment-h2">Pay Your Bill</h2>

        <%
        Consumer consumer = (Consumer) session.getAttribute("consumer");
        Bill bill = (Bill) session.getAttribute("currentBill");
        Double totalDue = (Double) session.getAttribute("totalDue");

        if (consumer == null || bill == null || totalDue == null) {
            response.sendRedirect("BillListServlet");
            return;
        }
        %>

        <form action="PaymentProcessingServlet" method="post" class="payment-form">
            <table class="payment-table">
                <tr>
                    <td>Name:</td>
                    <td><%= consumer.getName() %></td>
                </tr>
                <tr>
                    <td>Consumer No:</td>
                    <td><%= consumer.getConsumerId() %></td>
                </tr>
                <tr>
                    <td>Bill ID:</td>
                    <td><%= bill.getBillId() %></td>
                </tr>
                <tr>
                    <td>Bill Units:</td>
                    <td><%= bill.getUnit() %> kWh</td>
                </tr>
                <tr>
                    <td>Bill Month:</td>
                    <td><%= bill.getMonth() %></td>
                </tr>
                <tr>
                    <td>Bill Date:</td>
                    <td><%= bill.getDate() %></td>
                </tr>
                <tr>
                    <td>Due Date:</td>
                    <td><%= bill.getDueDate() %></td>
                </tr>
                <tr>
                    <td>Total Due Amount:</td>
                    <td>$<%= totalDue %></td>
                </tr>
                <tr>
                    <td>Payment Method:</td>
                    <td>
                        <select name="paymentMethod" class="payment-select">
                            <option value="debit">Debit Card</option>
                            <option value="credit">Credit Card</option>
                        </select>
                    </td>
                </tr>
            </table>

            <input type="hidden" name="consumerNo" value="<%= consumer.getConsumerId() %>" class="payment-input">
            <input type="hidden" name="billId" value="<%= bill.getBillId() %>" class="payment-input">
            <input type="hidden" name="totalAmount" value="<%= totalDue %>" class="payment-input">
            <input type="submit" value="Pay Now" class="payment-input">
            <a href="BillListServlet" class="payment-a">Cancel</a>
        </form>

        <%-- Footer --%>
        <%@ include file="fragments/footer.jsp"%>
    </div>
</body>
</html>