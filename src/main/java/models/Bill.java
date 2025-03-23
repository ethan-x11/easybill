package models;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class Bill {
    private String billId;
    private long consumerId;
    private int unit;
    private String month;
    private double amount;
    private LocalDate date;
    private LocalDate dueDate;
    private String paymentStatus;
    private String transactionId;
    private LocalDateTime transactionDateTime;

    public Bill(String billId, long consumerId, int unit, String month, double amount, LocalDate date, LocalDate dueDate, String paymentStatus, String transactionId, LocalDateTime transactionDateTime) {
        this.billId = billId;
        this.consumerId = consumerId;
        this.unit = unit;
        this.month = month;
        this.amount = amount;
        this.date = date;
        this.dueDate = dueDate;
        this.paymentStatus = paymentStatus;
        this.transactionId = transactionId;
        this.transactionDateTime = transactionDateTime;
    }

    public Bill(String billId, long consumerId, int unit, String month, double amount, LocalDate date, LocalDate dueDate, String paymentStatus) {
        this.billId = billId;
        this.consumerId = consumerId;
        this.unit = unit;
        this.month = month;
        this.amount = amount;
        this.date = date;
        this.dueDate = dueDate;
        this.paymentStatus = paymentStatus;
    }

    // Getters and setters
    public String getBillId() { return billId; }
    public void setBillId(String billId) { this.billId = billId; }

    public long getConsumerId() { return consumerId; }
    public void setConsumerId(long consumerId) { this.consumerId = consumerId; }

    public int getUnit() { return unit; }
    public void setUnit(int unit) { this.unit = unit; }

    public String getMonth() { return month; }
    public void setMonth(String month) { this.month = month; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public LocalDate getDate() { return date; }
    public void setDate(LocalDate date) { this.date = date; }

    public LocalDate getDueDate() { return dueDate; }
    public void setDueDate(LocalDate dueDate) { this.dueDate = dueDate; }

    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }

    public String getTransactionId() { return transactionId; }
    public void setTransactionId(String transactionId) { this.transactionId = transactionId; }

    public LocalDateTime getTransactionDateTime() { return transactionDateTime; }
    public void setTransactionDateTime(LocalDateTime transactionDateTime) { this.transactionDateTime = transactionDateTime; }

    public void updatePaymentStatus(String newStatus) {
        this.paymentStatus = newStatus;
    }
}