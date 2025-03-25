package dao;

import java.util.Date;

import models.Consumer;

public class ConsumerWithBillInfo extends Consumer {
    private double latestBillAmount;
    private String latestBillMonth;
    private Date latestBillDate;

    public ConsumerWithBillInfo(long consumerId, String name, String email, String countryCode, String mobileNumber, String userId, double latestBillAmount, String latestBillMonth, Date latestBillDate) {
        super(consumerId, name, email, countryCode, mobileNumber, userId);
        this.latestBillAmount = latestBillAmount;
        this.latestBillMonth = latestBillMonth;
        this.latestBillDate = latestBillDate;
    }

    // Getters and setters for the new fields
    public double getLatestBillAmount() {
        return latestBillAmount;
    }

    public void setLatestBillAmount(double latestBillAmount) {
        this.latestBillAmount = latestBillAmount;
    }

    public String getLatestBillMonth() {
        return latestBillMonth;
    }

    public void setLatestBillMonth(String latestBillMonth) {
        this.latestBillMonth = latestBillMonth;
    }

    public Date getLatestBillDate() {
        return latestBillDate;
    }

    public void setLatestBillDate(Date latestBillDate) {
        this.latestBillDate = latestBillDate;
    }
}