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
import java.util.List;

@WebServlet("/ComplaintsManagerServlet")
public class ComplaintsManagerServlet extends HttpServlet {
    private ComplaintService complaintService;

    @Override
    public void init() throws ServletException {
        this.complaintService = new ComplaintService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        String filter = request.getParameter("filter");

        try {
            List<Complaint> complaints = complaintService.searchComplaints(query, filter);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(buildJsonResponse(complaints));
        } catch (SQLException e) {
            throw new ServletException("Error retrieving complaints", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long complaintId = Long.parseLong(request.getParameter("complaintId"));
        String status = request.getParameter("status");

        try {
            int updateStatus = complaintService.updateComplaintStatus(complaintId, status);
            if (updateStatus > 0) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Complaint status updated successfully");
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Failed to update complaint status");
            }
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error updating complaint status");
        }
    }

    private String buildJsonResponse(List<Complaint> complaints) {
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < complaints.size(); i++) {
            Complaint complaint = complaints.get(i);
            json.append("{")
                .append("\"complaintId\":").append(complaint.getComplaintId()).append(",")
                .append("\"complaintType\":\"").append(complaint.getComplaintType()).append("\",")
                .append("\"category\":\"").append(complaint.getCategory()).append("\",")
                .append("\"contactPerson\":\"").append(complaint.getContactPerson()).append("\",")
                .append("\"consumerId\":").append(complaint.getConsumerId()).append(",")
                .append("\"mobileNumber\":\"").append(complaint.getMobileNumber()).append("\",")
                .append("\"complaintDate\":\"").append(complaint.getComplaintDate()).append("\",")
                .append("\"problemDescription\":\"").append(complaint.getProblemDescription()).append("\",")
                .append("\"address\":\"").append(complaint.getAddress()).append("\",")
                .append("\"landmark\":\"").append(complaint.getLandmark()).append("\",")
                .append("\"status\":\"").append(complaint.getStatus()).append("\"")
                .append("}");
            if (i < complaints.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");
        return json.toString();
    }
}