package services;

import models.Complaint;
import repositories.ComplaintRepository;

import java.sql.SQLException;
import java.util.List;

public class ComplaintService {
    private final ComplaintRepository complaintRepository;

    public ComplaintService() {
        this.complaintRepository = new ComplaintRepository();
    }

    public void registerComplaint(Complaint complaint) throws SQLException {
        complaintRepository.createComplaint(complaint);
    }

    public Complaint getComplaintById(long complaintId) throws SQLException {
        return complaintRepository.getComplaintById(complaintId);
    }

    public List<Complaint> getComplaintsByConsumerId(long consumerId) throws SQLException {
        return complaintRepository.getComplaintsByConsumerId(consumerId);
    }

    public List<Complaint> searchComplaints(String query) throws SQLException {
        return complaintRepository.searchComplaints(query);
    }

    public List<Complaint> searchComplaints(String query, String filter) throws SQLException {
        return complaintRepository.searchComplaints(query, filter);
    }

    public int updateComplaintStatus(long complaintId, String status) throws SQLException {
        return complaintRepository.updateComplaintStatus(complaintId, status);
    }
}