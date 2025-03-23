package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.security.NoSuchAlgorithmException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Consumer;
import services.ConsumerService;
import services.IConsumerService;

@WebServlet("/RegistrationHandlerServlet")
public class RegistrationHandlerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IConsumerService consumerService;

    @Override
    public void init() throws ServletException {
        this.consumerService = new ConsumerService();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String consumerIdStr = request.getParameter("consumerId");
        long consumerId = Long.parseLong(consumerIdStr);
        String consumerName = request.getParameter("consumerName");
        String email = request.getParameter("email");
        String countryCode = request.getParameter("countryCode");
        String mobileNumber = request.getParameter("mobileNumber");
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");

        Consumer user = new Consumer(consumerId, consumerName, email, countryCode, mobileNumber, userId);

        try {
            consumerService.registerConsumer(user, password);
            request.setAttribute("consumerId", consumerIdStr);
            request.setAttribute("userId", userId);
            request.setAttribute("consumerName", consumerName);
            request.setAttribute("username", userId);
            request.setAttribute("email", email);
            request.getRequestDispatcher("registration_success.jsp").forward(request, response);
        } catch (SQLException | NoSuchAlgorithmException e) {
            if (e.getMessage().contains("UNIQUE constraint failed")) {
                request.setAttribute("errorMessage", "User already exists. Please try Login");
            } else {
                request.setAttribute("errorMessage", "There was an error processing your registration. Please try again later.");
            }
            request.getRequestDispatcher("registration_failed.jsp").forward(request, response);
        }
    }
}