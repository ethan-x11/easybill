package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Bill;
import services.BillService;

@WebServlet("/SearchConsumerForBillServlet")
public class SearchConsumerForBillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final BillService billService;

    public SearchConsumerForBillServlet() {
        this.billService = new BillService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String searchQuery = request.getParameter("query");

        try {
            List<Bill> bills = billService.searchConsumersForBill(searchQuery);
            for (Bill bill : bills) {
                // System.out.println(bill.getBillId());
                out.println("<tr><td>" + bill.getBillId() + "</td>");
                out.println("<td>" + bill.getConsumerId() + "</td>");
                out.println("<td>" + bill.getAmount() + "</td>");
                out.println("<td>" + bill.getDueDate() + "</td>");
                out.println("<td>" + bill.getPaymentStatus() + "</td>");
                out.println("<td><button onclick=\"setCustomerId('" + bill.getConsumerId() + "')\">Generate Bill</button></td></tr>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}