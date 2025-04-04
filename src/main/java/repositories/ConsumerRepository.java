package repositories;

import models.Consumer;
import utils.ConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.ConsumerWithBillInfo;

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

    public List<ConsumerWithBillInfo> searchConsumers(String query, String filter) throws SQLException {
        String sql = "SELECT c.consumerId, c.name, c.email, c.country_code, c.mobile_number, c.userId, " +
                 "b.amount AS latestBillAmount, b.month AS latestBillMonth, b.date AS latestBillDate " +
                 "FROM consumer c " +
                 "LEFT JOIN ( " +
                 "    SELECT b1.* " +
                 "    FROM bill b1 " +
                 "    INNER JOIN ( " +
                 "        SELECT consumerId, MAX(date) AS latestDate " +
                 "        FROM bill " +
                 "        GROUP BY consumerId " +
                 "    ) b2 ON b1.consumerId = b2.consumerId AND b1.date = b2.latestDate " +
                 ") b ON c.consumerId = b.consumerId " +
                 "WHERE (c.name LIKE ? OR c.userId LIKE ?)"; 

        if ("Paid".equalsIgnoreCase(filter)) {
            sql += " AND b.payment_status = 'Paid'";
        } else if ("Unpaid".equalsIgnoreCase(filter)) {
            sql += " AND b.payment_status = 'Unpaid'";
        }

        List<ConsumerWithBillInfo> consumers = new ArrayList<>();
        try (Connection connection = ConnectionManager.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, "%" + query + "%");
            statement.setString(2, "%" + query + "%");
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    ConsumerWithBillInfo consumer = new ConsumerWithBillInfo(
                        resultSet.getLong("consumerId"),
                        resultSet.getString("name"),
                        resultSet.getString("email"),
                        resultSet.getString("country_code"),
                        resultSet.getString("mobile_number"),
                        resultSet.getString("userId"),
                        resultSet.getDouble("latestBillAmount"),
                        resultSet.getString("latestBillMonth"),
                        resultSet.getDate("latestBillDate")
                    );
                    consumers.add(consumer);
                }
            }
        }
        return consumers;
    }
}