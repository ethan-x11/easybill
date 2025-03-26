package repositories;

import models.Complaint;
import utils.ConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ComplaintRepository {

    public void createComplaint(Complaint complaint) throws SQLException {
        String sql = "INSERT INTO complaint (complaintId, complaint_type, category, contact_person, consumerId, mobile_number, complaint_date, problem_description, address, landmark) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = ConnectionManager.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, complaint.getComplaintId());
            statement.setString(2, complaint.getComplaintType());
            statement.setString(3, complaint.getCategory());
            statement.setString(4, complaint.getContactPerson());
            statement.setLong(5, complaint.getConsumerId());
            statement.setString(6, complaint.getMobileNumber());
            statement.setDate(7, new java.sql.Date(complaint.getComplaintDate().getTime()));
            statement.setString(8, complaint.getProblemDescription());
            statement.setString(9, complaint.getAddress());
            statement.setString(10, complaint.getLandmark());
            statement.executeUpdate();
        }
    }

    public Complaint getComplaintById(long complaintId) throws SQLException {
        String sql = "SELECT * FROM complaint WHERE complaintId = ?";
        try (Connection connection = ConnectionManager.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, complaintId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return new Complaint(
                            resultSet.getLong("complaintId"),
                            resultSet.getString("complaint_type"),
                            resultSet.getString("category"),
                            resultSet.getString("contact_person"),
                            resultSet.getLong("consumerId"),
                            resultSet.getString("mobile_number"),
                            resultSet.getDate("complaint_date"),
                            resultSet.getString("problem_description"),
                            resultSet.getString("address"),
                            resultSet.getString("landmark"),
                            resultSet.getString("status"));
                } else {
                    return null;
                }
            }
        }
    }

    public List<Complaint> getComplaintsByConsumerId(long consumerId) throws SQLException {
        String sql = "SELECT * FROM complaint WHERE consumerId = ?";
        List<Complaint> complaints = new ArrayList<>();
        try (Connection connection = ConnectionManager.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, consumerId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Complaint complaint = new Complaint(
                            resultSet.getLong("complaintId"),
                            resultSet.getString("complaint_type"),
                            resultSet.getString("category"),
                            resultSet.getString("contact_person"),
                            resultSet.getLong("consumerId"),
                            resultSet.getString("mobile_number"),
                            resultSet.getDate("complaint_date"),
                            resultSet.getString("problem_description"),
                            resultSet.getString("address"),
                            resultSet.getString("landmark"),
                            resultSet.getString("status"));
                    complaints.add(complaint);
                }
            }
        }
        return complaints;
    }

    public List<Complaint> searchComplaints(String query) throws SQLException {
        String sql = "SELECT * FROM complaint WHERE contact_person LIKE ? OR complaintId LIKE ?";
        List<Complaint> complaints = new ArrayList<>();
        try (Connection connection = ConnectionManager.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, "%" + query + "%");
            statement.setString(2, "%" + query + "%");
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Complaint complaint = new Complaint(
                            resultSet.getLong("complaintId"),
                            resultSet.getString("complaint_type"),
                            resultSet.getString("category"),
                            resultSet.getString("contact_person"),
                            resultSet.getLong("consumerId"),
                            resultSet.getString("mobile_number"),
                            resultSet.getDate("complaint_date"),
                            resultSet.getString("problem_description"),
                            resultSet.getString("address"),
                            resultSet.getString("landmark"),
                            resultSet.getString("status"));
                    complaints.add(complaint);
                }
            }
        }
        return complaints;
    }

    public List<Complaint> searchComplaints(String query, String filter) throws SQLException {
        List<Complaint> complaints = new ArrayList<>();
        String sql = "SELECT * FROM complaint WHERE (consumerId LIKE ? OR contact_person LIKE ? OR category LIKE ? OR complaint_type LIKE ?)";

        if (filter != null && !filter.isEmpty()) {
            sql += " AND status = ?";
        }

        try (Connection connection = ConnectionManager.getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, "%" + query + "%");
            stmt.setString(2, "%" + query + "%");
            stmt.setString(3, "%" + query + "%");
            stmt.setString(4, "%" + query + "%");

            if (filter != null && !filter.isEmpty()) {
                stmt.setString(5, filter);
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Complaint complaint = new Complaint(
                        rs.getLong("complaintId"),
                        rs.getString("complaint_type"),
                        rs.getString("category"),
                        rs.getString("contact_person"),
                        rs.getLong("consumerId"),
                        rs.getString("mobile_number"),
                        rs.getDate("complaint_date"),
                        rs.getString("problem_description"),
                        rs.getString("address"),
                        rs.getString("landmark"),
                        rs.getString("status"));
                complaints.add(complaint);
            }
        }

        return complaints;
    }

    public int updateComplaintStatus(long complaintId, String status) throws SQLException {
        String sql = "UPDATE complaint SET status = ? WHERE complaintId = ?";
        try (Connection connection = ConnectionManager.getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setLong(2, complaintId);
            return stmt.executeUpdate();
        }
    }
}