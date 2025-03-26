package servlets;

import services.BillService;
import models.Bill;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CreateBillServlet")
public class CreateBillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final BillService billService = new BillService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String consumerId = request.getParameter("billConsumerId");
        String unit = request.getParameter("billUnit");
        String amount = request.getParameter("billAmount");
        String date = request.getParameter("billDate");
        String status = request.getParameter("billStatus");

        // Debugging: Log received parameters
        System.out.println("Received parameters:");
        System.out.println("Consumer ID: " + consumerId);
        System.out.println("Unit: " + unit);
        System.out.println("Amount: " + amount);
        System.out.println("Date: " + date);
        System.out.println("Status: " + status);

        if (consumerId == null || unit == null || amount == null || date == null || status == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid input");
            return;
        }

        try {
            LocalDate parsedDate = LocalDate.parse(date, DateTimeFormatter.ISO_LOCAL_DATE);
            String dueDate = parsedDate.plusDays(15).toString();
            // Generate unique bill ID
            String billId = "BILL" + UUID.randomUUID().toString().substring(0, 8);
            LocalDate parsedDueDate = LocalDate.parse(dueDate, DateTimeFormatter.ISO_LOCAL_DATE);
            String month = parsedDate.getMonth().toString();

            Bill bill = new Bill(billId, Long.parseLong(consumerId), Integer.parseInt(unit), month, Double.parseDouble(amount), parsedDate, parsedDueDate, status);
            int createStatus = billService.createBill(bill);
            if (createStatus == 0) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Customer Id Not Found");
                return;
            }
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Bill created successfully");
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            if (e.getMessage().contains("unique constraint")) {
                response.getWriter().write("Bill Already Created for the Given Month");
            } else {
                response.getWriter().write("Database error");
            }
        }
    }
}
