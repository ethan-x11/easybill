package models;

import java.util.Date;

public class Complaint {
    private long complaintId;
    private String complaintType;
    private String category;
    private String contactPerson;
    private long consumerId;
    private String mobileNumber;
    private Date complaintDate;
    private String problemDescription;
    private String address;
    private String landmark;
    private String status; // Added status field

    public Complaint(long complaintId, String complaintType, String category, String contactPerson, long consumerId, String mobileNumber, Date complaintDate, String problemDescription, String address, String landmark) {
        this.complaintId = complaintId;
        this.complaintType = complaintType;
        this.category = category;
        this.contactPerson = contactPerson;
        this.consumerId = consumerId;
        this.mobileNumber = mobileNumber;
        this.complaintDate = complaintDate;
        this.problemDescription = problemDescription;
        this.address = address;
        this.landmark = landmark;
    }

    public Complaint(long complaintId, String complaintType, String category, String contactPerson, long consumerId, String mobileNumber, Date complaintDate, String problemDescription, String address, String landmark, String status) {
        this.complaintId = complaintId;
        this.complaintType = complaintType;
        this.category = category;
        this.contactPerson = contactPerson;
        this.consumerId = consumerId;
        this.mobileNumber = mobileNumber;
        this.complaintDate = complaintDate;
        this.problemDescription = problemDescription;
        this.address = address;
        this.landmark = landmark;
        this.status = status;
    }

    public long getComplaintId() {
        return complaintId;
    }

    public void setComplaintId(long complaintId) {
        this.complaintId = complaintId;
    }

    public String getComplaintType() {
        return complaintType;
    }

    public void setComplaintType(String complaintType) {
        this.complaintType = complaintType;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getContactPerson() {
        return contactPerson;
    }

    public void setContactPerson(String contactPerson) {
        this.contactPerson = contactPerson;
    }

    public long getConsumerId() {
        return consumerId;
    }

    public void setConsumerId(long consumerId) {
        this.consumerId = consumerId;
    }

    public String getMobileNumber() {
        return mobileNumber;
    }

    public void setMobileNumber(String mobileNumber) {
        this.mobileNumber = mobileNumber;
    }

    public Date getComplaintDate() {
        return complaintDate;
    }

    public void setComplaintDate(Date complaintDate) {
        this.complaintDate = complaintDate;
    }

    public String getProblemDescription() {
        return problemDescription;
    }

    public void setProblemDescription(String problemDescription) {
        this.problemDescription = problemDescription;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getLandmark() {
        return landmark;
    }

    public void setLandmark(String landmark) {
        this.landmark = landmark;
    }

    public String getStatus() {
        return status; // Getter for status
    }

    public void setStatus(String status) {
        this.status = status; // Setter for status
    }
}