package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Bill;
import services.BillService;

@WebServlet("/BillListServlet")
public class BillListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BillService billService;

    @Override
    public void init() throws ServletException {
        this.billService = new BillService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Bill> bills = billService.getAllBills();
            request.setAttribute("bills", bills);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error while fetching bills");
        }
        request.getRequestDispatcher("bill_listing.jsp").forward(request, response);
    }
}