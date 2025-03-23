package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
        HttpSession session = request.getSession();
        Long consumerId = (Long) session.getAttribute("consumerId");

        if (consumerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            List<Bill> bills = billService.getBillsByConsumerId(consumerId);
            request.setAttribute("bills", bills);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error while fetching bills");
        }
        request.getRequestDispatcher("bill_listing.jsp").forward(request, response);
    }
}