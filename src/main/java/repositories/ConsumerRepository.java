package repositories;

import models.Consumer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConsumerRepository {

    public void createConsumer(Consumer consumer) throws SQLException {
        String sql = "INSERT INTO consumer (consumerId, name, email, country_code, mobile_number, userId) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection connection = ConnectionManager.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, consumer.getConsumerId());
            statement.setString(2, consumer.getName());
            statement.setString(3, consumer.getEmail());
            statement.setString(4, consumer.getCountryCode());
            statement.setString(5, consumer.getMobileNumber());
            statement.setString(6, consumer.getUserId());
            statement.executeUpdate();
        }
    }

    public void createLoginData(long consumerId, String userId, String hashedPassword) throws SQLException {
        String sql = "INSERT INTO logindata (userId, consumerId, hash_token) VALUES (?, ?, ?)";
        try (Connection connection = ConnectionManager.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, userId);
            statement.setLong(2, consumerId);
            statement.setString(3, hashedPassword);
            statement.executeUpdate();
        }
    }

    public Consumer validateConsumer(String userId, String hashedPassword) throws SQLException {
        String sql = "SELECT * FROM consumer c JOIN logindata l ON c.consumerId = l.consumerId WHERE l.userId = ? AND l.hash_token = ?";
        try (Connection connection = ConnectionManager.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, userId);
            statement.setString(2, hashedPassword);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return new Consumer(
                        resultSet.getLong("consumerId"),
                        resultSet.getString("name"),
                        resultSet.getString("email"),
                        resultSet.getString("country_code"),
                        resultSet.getString("mobile_number"),
                        resultSet.getString("userId")
                    );
                } else {
                    return null;
                }
            }
        }
    }
}