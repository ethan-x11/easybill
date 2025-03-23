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
        
        String consumerId = request.getParameter("billCustomerId");
        String unit = request.getParameter("billUnit");
        String amount = request.getParameter("billAmount");
        String date = request.getParameter("billDate");
        LocalDate parsedDate = LocalDate.parse(date, DateTimeFormatter.ISO_LOCAL_DATE);
        String dueDate = parsedDate.plusDays(15).toString();
        String status = request.getParameter("billStatus");

        if (consumerId == null || unit == null || amount == null || date == null || status == null) {
            response.sendRedirect("createBill.jsp?error=Invalid input");
            return;
        }

        try {
            // Generate unique bill ID
            String billId = "BILL-" + UUID.randomUUID().toString().substring(0, 8);
            LocalDate parsedDueDate = LocalDate.parse(dueDate, DateTimeFormatter.ISO_LOCAL_DATE);
            String month = parsedDate.getMonth().toString();

            Bill bill = new Bill(billId, Long.parseLong(consumerId), Integer.parseInt(unit), month, Double.parseDouble(amount), parsedDate, parsedDueDate, status);
            billService.createBill(bill);
            response.sendRedirect("createBill.jsp?success=Bill created successfully");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("createBill.jsp?error=Database error");
        }
    }
}
