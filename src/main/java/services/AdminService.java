package services;

import repositories.AdminRepository;
import utils.PasswordEncrytion;

import java.sql.SQLException;
import java.security.NoSuchAlgorithmException;

public class AdminService {
    private final AdminRepository adminRepository;

    public AdminService() {
        this.adminRepository = new AdminRepository();
    }

    public boolean validateAdmin(String adminId, String password) throws SQLException, NoSuchAlgorithmException {
        String hashedPassword = PasswordEncrytion.hashPassword(password);
        return adminRepository.validateAdmin(adminId, hashedPassword);
    }

    public void registerAdmin(String adminId, String password) throws SQLException, NoSuchAlgorithmException {
        String hashedPassword = PasswordEncrytion.hashPassword(password);
        adminRepository.createAdmin(adminId, hashedPassword);
    }
}