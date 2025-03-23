package models;

public class Consumer {
    private long consumerId;
    private String name;
    private String email;
    private String countryCode;
    private String mobileNumber;
    private String userId;

    public Consumer(long consumerId, String name, String email, String countryCode, String mobileNumber, String userId) {
        this.consumerId = consumerId;
        this.name = name;
        this.email = email;
        this.countryCode = countryCode;
        this.mobileNumber = mobileNumber;
        this.userId = userId;
    }

    // Getters and setters
    public long getConsumerId() { return consumerId; }
    public void setConsumerId(long consumerId) { this.consumerId = consumerId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getCountryCode() { return countryCode; }
    public void setCountryCode(String countryCode) { this.countryCode = countryCode; }

    public String getMobileNumber() { return mobileNumber; }
    public void setMobileNumber(String mobileNumber) { this.mobileNumber = mobileNumber; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
}