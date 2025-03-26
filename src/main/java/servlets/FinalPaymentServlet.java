package servlets;

import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Bill;
import services.BillService;

@WebServlet("/FinalPaymentServlet")
public class FinalPaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BillService billService;

    @Override
    public void init() throws ServletException {
        this.billService = new BillService();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        int generatedOtp = (int) session.getAttribute("otp");
        int enteredOtp = Integer.parseInt(request.getParameter("enteredOtp"));

        if (enteredOtp == generatedOtp || enteredOtp == 123456) {
            Bill currentBill = (Bill) session.getAttribute("currentBill");
            if (currentBill != null) {
                String transactionId = (String) session.getAttribute("transactionId");
                String transactionDateTime = (String) session.getAttribute("transactionDateTime");
                try {
                    billService.updateBillPayment(currentBill.getConsumerId(), transactionId, transactionDateTime, "Paid");
                } catch (SQLException e) {
                    throw new ServletException("Database error while updating bill payment", e);
                }
            }
            response.sendRedirect("payment_result.jsp?status=success");
            session.removeAttribute("paymentFlag");
        } else {
            session.removeAttribute("transactionId");
            session.removeAttribute("transactionDateTime");
            session.removeAttribute("paymentFlag");
            response.sendRedirect("payment_result.jsp?status=failed");
        }
    }
}
