package servlets;

import models.Bill;
import services.BillService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/ConsumerBillServlet")
public class ConsumerBillServlet extends HttpServlet {
    private BillService billService;

    @Override
    public void init() throws ServletException {
        this.billService = new BillService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String consumerId = request.getParameter("consumerId");
        String query = request.getParameter("query");
        if (query == null) {
            query = "";
        }
        System.out.println("query = " + query);
        try {
            List<Bill> bills = billService.searchBills(consumerId, query);
            for (Bill bill : bills) {
                System.out.println(bill.getBillId());
            }
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(buildJsonResponse(bills));
        } catch (SQLException e) {
            throw new ServletException("Error retrieving bills", e);
        }
    }

    private String buildJsonResponse(List<Bill> bills) {
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < bills.size(); i++) {
            Bill bill = bills.get(i);
            json.append("{")
                .append("\"billId\":\"").append(bill.getBillId()).append("\",")
                .append("\"consumerId\":").append(bill.getConsumerId()).append(",")
                .append("\"unit\":").append(bill.getUnit()).append(",")
                .append("\"month\":\"").append(bill.getMonth()).append("\",")
                .append("\"amount\":").append(bill.getAmount()).append(",")
                .append("\"date\":\"").append(bill.getDate()).append("\",")
                .append("\"dueDate\":\"").append(bill.getDueDate()).append("\",")
                .append("\"paymentStatus\":\"").append(bill.getPaymentStatus()).append("\",")
                .append("\"transactionId\":\"").append(bill.getTransactionId()).append("\",")
                .append("\"transactionDateTime\":\"").append(bill.getTransactionDateTime()).append("\"")
                .append("}");
            if (i < bills.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");
        System.out.println("JSON - " + json.toString());
        return json.toString();
    }
}