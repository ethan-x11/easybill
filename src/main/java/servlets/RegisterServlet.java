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
import models.Admin;
import services.ConsumerService;
import services.AdminService;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ConsumerService consumerService;
    private AdminService adminService;

    @Override
    public void init() throws ServletException {
        this.consumerService = new ConsumerService();
        this.adminService = new AdminService();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String countryCode = request.getParameter("country_code");
        String mobileNumber = request.getParameter("mobile_number");
        String userId = request.getParameter("userId");
        String role = request.getParameter("role");
        String password = request.getParameter("password");

        try {
            if ("user".equals(role)) {
                long consumerId = Long.parseLong(request.getParameter("consumerId"));
                Consumer consumer = new Consumer(consumerId, name, email, countryCode, mobileNumber, userId);
                consumerService.registerConsumer(consumer, password);
            } else if ("admin".equals(role) && password != null && !password.isEmpty()) {
                Admin admin = new Admin(userId, name, password);
                adminService.registerAdmin(admin);
            }
            response.getWriter().println("Success");
        } catch (SQLException | NoSuchAlgorithmException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}