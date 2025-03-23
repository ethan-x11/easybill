package servlets;

import models.Complaint;
import services.ComplaintService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;

@WebServlet("/ComplaintRegistrationServlet")
public class ComplaintRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ComplaintService complaintService;

    @Override
    public void init() throws ServletException {
        this.complaintService = new ComplaintService();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long complaintId = Long.parseLong(request.getParameter("complaint_id"));
        String complaintType = request.getParameter("complaint_type");
        String category = request.getParameter("category");
        String contactPerson = request.getParameter("contact_person");
        long consumerId = Long.parseLong(request.getParameter("consumer_no"));
        String mobileNumber = request.getParameter("mobile_no");
        Date complaintDate = java.sql.Date.valueOf(request.getParameter("complaint_date"));
        String problemDescription = request.getParameter("problem_description");
        String address = request.getParameter("address");
        String landmark = request.getParameter("landmark");

        Complaint complaint = new Complaint(complaintId, complaintType, category, contactPerson, consumerId, mobileNumber, complaintDate, problemDescription, address, landmark);

        try {
            complaintService.registerComplaint(complaint);
            response.sendRedirect("complaint_registration.jsp?status=success&complaintId=" + complaintId);
        } catch (SQLException e) {
            throw new ServletException("Database error while registering complaint", e);
        }
    }
}