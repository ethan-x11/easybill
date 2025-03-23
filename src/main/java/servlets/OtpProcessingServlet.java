package servlets;

import java.io.IOException;
import java.util.Random;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpSession;

@WebServlet("/OtpProcessingServlet")
public class OtpProcessingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        if (session.getAttribute("transactionId") == null || session.getAttribute("transactionDateTime") == null) {
            response.sendRedirect("BillListServlet");
            return;
        }

        int otp = new Random().nextInt(900000) + 100000;
        session.setAttribute("otp", otp);

        RequestDispatcher dispatcher = request.getRequestDispatcher("otp_verification.jsp");
        dispatcher.forward(request, response);
    }
}