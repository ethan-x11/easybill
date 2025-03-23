package models;

public class Bill {
    private String billId;
    private int unit;
    private String month;
    private String date;
    private String dueDate;
    private double amount;
    private String paymentStatus;
    private long consumerId;
    private String transactionId;
    private String transactionDateTime;

    public Bill(String billId, int unit, String month, String date, String dueDate, double amount, String paymentStatus, long consumerId, String transactionId, String transactionDateTime) {
        this.billId = billId;
        this.unit = unit;
        this.month = month;
        this.date = date;
        this.dueDate = dueDate;
        this.amount = amount;
        this.paymentStatus = paymentStatus;
        this.consumerId = consumerId;
        this.transactionId = transactionId;
        this.transactionDateTime = transactionDateTime;
    }
    
    public Bill(String billId, int unit, String month, String date, String dueDate, double amount, String paymentStatus, long consumerId) {
        this.billId = billId;
        this.unit = unit;
        this.month = month;
        this.date = date;
        this.dueDate = dueDate;
        this.amount = amount;
        this.paymentStatus = paymentStatus;
        this.consumerId = consumerId;
    }

    // Getters and setters
    public String getBillId() { return billId; }
    public void setBillId(String billId) { this.billId = billId; }

    public int getUnit() { return unit; }
    public void setUnit(int unit) { this.unit = unit; }

    public String getMonth() { return month; }
    public void setMonth(String month) { this.month = month; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }

    public String getDueDate() { return dueDate; }
    public void setDueDate(String dueDate) { this.dueDate = dueDate; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }

    public long getConsumerId() { return consumerId; }
    public void setConsumerId(long consumerId) { this.consumerId = consumerId; }

    public String getTransactionId() { return transactionId; }
    public void setTransactionId(String transactionId) { this.transactionId = transactionId; }

    public String getTransactionDateTime() { return transactionDateTime; }
    public void setTransactionDateTime(String transactionDateTime) { this.transactionDateTime = transactionDateTime; }

    public void updatePaymentStatus(String newStatus) {
        this.paymentStatus = newStatus;
    }
}