package services;

import repositories.AdminRepository;
import utils.PasswordEncryption;

import java.sql.SQLException;

import models.Admin;

import java.security.NoSuchAlgorithmException;

public class AdminService {
    private final AdminRepository adminRepository;

    public AdminService() {
        this.adminRepository = new AdminRepository();
    }

    public boolean validateAdmin(String adminId, String password) throws SQLException, NoSuchAlgorithmException {
        String hashedPassword = PasswordEncryption.hashPassword(password);
        return adminRepository.validateAdmin(adminId, hashedPassword);
    }

    public void registerAdmin(Admin admin) throws SQLException, NoSuchAlgorithmException {
        String hashedPassword = PasswordEncryption.hashPassword(admin.getHashedPassword());
        admin.setHashedPassword(hashedPassword);
        adminRepository.createAdmin(admin);
    }
}