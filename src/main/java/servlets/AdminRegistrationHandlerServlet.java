package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.security.NoSuchAlgorithmException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import services.AdminService;

@WebServlet("/AdminRegistrationHandlerServlet")
public class AdminRegistrationHandlerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdminService adminService;

    @Override
    public void init() throws ServletException {
        this.adminService = new AdminService();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String adminId = request.getParameter("adminId");
        String password = request.getParameter("password");

        try {
            adminService.registerAdmin(adminId, password);
            request.setAttribute("statusMessage", "Admin registration successful. Admin ID: " + adminId);
        } catch (SQLException | NoSuchAlgorithmException e) {
            if (e.getMessage().contains("UNIQUE constraint failed")) {
                request.setAttribute("statusMessage", "Admin already exists. Please try Login.");
            } else {
                request.setAttribute("statusMessage", "There was an error processing your registration. Please try again later.");
            }
        }
        request.getRequestDispatcher("admin_registration_status.jsp").forward(request, response);
    }
}