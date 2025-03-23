package servlets;

import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Consumer;
import services.ConsumerService;
import services.AdminService;
import java.security.NoSuchAlgorithmException;

@WebServlet("/LoginHandlerServlet")
public class LoginHandlerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ConsumerService consumerService;
    private AdminService adminService;

    @Override
    public void init() throws ServletException {
        this.consumerService = new ConsumerService();
        this.adminService = new AdminService();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        String adminId = request.getParameter("adminId");

        HttpSession session = request.getSession();

        try {
            if (adminId != null) {
                if (adminService.validateAdmin(adminId, password)) {
                    session.setAttribute("username", adminId);
                    response.sendRedirect("admin.jsp");
                } else {
                    session.setAttribute("errorMessage", "Invalid Id or password");
                    // session.setAttribute("isAdmin", true);
                    response.sendRedirect("login.jsp?error=invalid");
                }
            } else {
                Consumer consumer = consumerService.validateConsumer(userId, password);
                if (consumer != null) {
                    session.setAttribute("username", consumer.getUserId());
                    session.setAttribute("consumerId", consumer.getConsumerId());
                    session.setAttribute("consumer", consumer);
                    response.sendRedirect("BillListServlet");
                } else {
                    session.setAttribute("errorMessage", "Invalid Id or password");
                    // session.setAttribute("isAdmin", false);
                    response.sendRedirect("login.jsp?error=invalid");
                }
            }
        } catch (SQLException | NoSuchAlgorithmException e) {
            throw new ServletException("Database error", e);
        }
    }
}