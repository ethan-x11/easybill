package servlets;

import models.Complaint;
import services.ComplaintService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/ComplaintSearchServlet")
public class ComplaintSearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ComplaintService complaintService;

    @Override
    public void init() throws ServletException {
        this.complaintService = new ComplaintService();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String complaintIdStr = request.getParameter("complaintId");
        if (complaintIdStr != null && !complaintIdStr.trim().isEmpty()) {
            long complaintId = Long.parseLong(complaintIdStr);
            try {
                Complaint complaint = complaintService.getComplaintById(complaintId);
                if (complaint != null) {
                    request.setAttribute("complaint", complaint);
                } else {
                    request.setAttribute("errorMessage", "Complaint ID not found.");
                }
            } catch (SQLException e) {
                request.setAttribute("errorMessage", "Error retrieving complaint details.");
                e.printStackTrace();
            }
        }
        request.getRequestDispatcher("complaint_search.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        long consumerId = (long) session.getAttribute("consumerId");
        try {
            List<Complaint> complaints = complaintService.getComplaintsByConsumerId(consumerId);
            if (complaints == null || complaints.isEmpty()) {
                request.setAttribute("message", "No Complaint Registered");
            } else {
                request.setAttribute("complaints", complaints);
            }
            request.getRequestDispatcher("complaint_view.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error while fetching complaints", e);
        }
    }
}