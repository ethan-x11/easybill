package servlets;

import models.Complaint;
import services.ComplaintService;
import utils.ConnectionManager;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ViewComplaintsServlet")
public class ViewComplaintsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ComplaintService complaintService;

    @Override
    public void init() throws ServletException {
        this.complaintService = new ComplaintService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        String searchQuery = request.getParameter("query");

        try {
            List<Complaint> complaints = complaintService.searchComplaints(searchQuery);
            StringBuilder jsonOutput = new StringBuilder("[");
            for (Complaint complaint : complaints) {
                jsonOutput.append("{")
                        .append("\"name\":\"").append(complaint.getContactPerson()).append("\",")
                        .append("\"complaintId\":\"").append(complaint.getComplaintId()).append("\",")
                        .append("\"description\":\"").append(complaint.getProblemDescription()).append("\",")
                        .append("\"solution\":\"").append("Pending").append("\",")
                        .append("\"status\":\"").append(complaint.getStatus()).append("\"")
                        .append("},");
            }
            if (jsonOutput.length() > 1) {
                jsonOutput.setLength(jsonOutput.length() - 1); // Remove trailing comma
            }
            jsonOutput.append("]");
            out.print(jsonOutput.toString());
            out.flush();
        } catch (SQLException e) {
            e.printStackTrace();
            out.print("{\"error\": \"Database error: " + e.getMessage() + "\"}");
        }
    }
}