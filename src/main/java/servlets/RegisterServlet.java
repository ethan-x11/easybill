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
        String adminName = request.getParameter("adminName");
        String email = request.getParameter("email");
        String countryCode = request.getParameter("country_code");
        String mobileNumber = request.getParameter("mobile_number");
        String adminUserId = request.getParameter("adminUserId");
        String userId = request.getParameter("userId");
        String role = request.getParameter("role");
        String password = request.getParameter("password");

        try {
            if ("consumer".equals(role)) {
                long consumerId = Long.parseLong(request.getParameter("consumerId"));
                Consumer consumer = new Consumer(consumerId, name, email, countryCode, mobileNumber, userId);
                consumerService.registerConsumer(consumer, password);
            } else if ("admin".equals(role) && password != null && !password.isEmpty()) {
                Admin admin = new Admin(adminUserId, adminName, password);
                adminService.registerAdmin(admin);
            }
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().println("Registration success");
        } catch (SQLException e) {
            if (e.getSQLState().equals("23505")) { // SQL state for unique constraint violation
                response.setStatus(HttpServletResponse.SC_CONFLICT);
                response.getWriter().println("Error: User already exists");
            } else {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().println("Error: Database Error");
            }
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().println("Error: Internal Server Error");
        }
    }
}