package models;

public class Admin {
    private String adminId;
    private String adminName;
    private String hashedPassword;

    public Admin(String adminId, String adminName, String hashedPassword) {
        this.adminId = adminId;
        this.adminName = adminName;
        this.hashedPassword = hashedPassword;
    }

    // Getters and setters
    public String getAdminId() {
        return adminId;
    }

    public void setAdminId(String adminId) {
        this.adminId = adminId;
    }

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }

    public String getHashedPassword() {
        return hashedPassword;
    }

    public void setHashedPassword(String hashedPassword) {
        this.hashedPassword = hashedPassword;
    }
}