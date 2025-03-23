package repositories;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminRepository {

    public boolean validateAdmin(String adminId, String hashedPassword) throws SQLException {
        String sql = "SELECT * FROM admin WHERE id = ? AND hash_token = ?";
        try (Connection connection = ConnectionManager.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, adminId);
            statement.setString(2, hashedPassword);
            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }
        }
    }

    public void createAdmin(String adminId, String hashedPassword) throws SQLException {
        String sql = "INSERT INTO admin (id, hash_token) VALUES (?, ?)";
        try (Connection connection = ConnectionManager.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, adminId);
            statement.setString(2, hashedPassword);
            statement.executeUpdate();
        }
    }
}