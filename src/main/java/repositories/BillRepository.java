package repositories;

import models.Bill;
import utils.ConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BillRepository {

    public List<Bill> getAllBills() throws SQLException {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM bill ORDER BY date DESC";
        try (Connection connection = ConnectionManager.getConnection();
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                Bill bill = new Bill(
                    resultSet.getString("billId"),
                    resultSet.getLong("consumerId"),
                    resultSet.getInt("unit"),
                    resultSet.getString("month"),
                    resultSet.getDouble("amount"),
                    resultSet.getDate("date").toLocalDate(),
                    resultSet.getDate("due_date").toLocalDate(),
                    resultSet.getString("payment_status"),
                    resultSet.getString("transaction_id"),
                    resultSet.getTimestamp("transaction_date_time") != null ? resultSet.getTimestamp("transaction_date_time").toLocalDateTime() : null
                );
                bills.add(bill);
            }
        }
        return bills;
    }

    public List<Bill> getBillsByConsumerId(long consumerId) throws SQLException {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM bill WHERE consumerId = ? ORDER BY date DESC";
        try (Connection connection = ConnectionManager.getConnection();
            PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, consumerId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Bill bill = new Bill(
                        resultSet.getString("billId"),
                        resultSet.getLong("consumerId"),
                        resultSet.getInt("unit"),
                        resultSet.getString("month"),
                        resultSet.getDouble("amount"),
                        resultSet.getDate("date").toLocalDate(),
                        resultSet.getDate("due_date").toLocalDate(),
                        resultSet.getString("payment_status"),
                        resultSet.getString("transaction_id"),
                        resultSet.getTimestamp("transaction_date_time") != null ? resultSet.getTimestamp("transaction_date_time").toLocalDateTime() : null
                    );
                    bills.add(bill);
                }
            }
        }
        return bills;
    }

    public void updateBillPayment(long consumerId, String transactionId, String transactionDateTime, String paymentStatus) throws SQLException {
        String sql = "UPDATE bill SET transaction_id = ?, transaction_date_time = ?, payment_status = ? WHERE consumerId = ? AND payment_status = 'unpaid'";
        try (Connection connection = ConnectionManager.getConnection();
            PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, transactionId);
            statement.setString(2, transactionDateTime);
            statement.setString(3, paymentStatus);
            statement.setLong(4, consumerId);
            statement.executeUpdate();
        }
    }

    public void createBill(Bill bill) throws SQLException {
        String sql = "INSERT INTO bill (billId, consumerId, unit, month, amount, date, due_date, payment_status, transaction_id, transaction_date_time) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, bill.getBillId());
            pstmt.setLong(2, bill.getConsumerId());
            pstmt.setInt(3, bill.getUnit());
            pstmt.setString(4, bill.getMonth());
            pstmt.setDouble(5, bill.getAmount());
            pstmt.setDate(6, java.sql.Date.valueOf(bill.getDate()));
            pstmt.setDate(7, java.sql.Date.valueOf(bill.getDueDate()));
            pstmt.setString(8, bill.getPaymentStatus());
            pstmt.setString(9, bill.getTransactionId());
            pstmt.setTimestamp(10, bill.getTransactionDateTime() != null ? java.sql.Timestamp.valueOf(bill.getTransactionDateTime()) : null);
            pstmt.executeUpdate();
        }
    }

    public List<Bill> searchConsumersForBill(String query) throws SQLException {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM consumer c LEFT JOIN bill b ON c.consumerId = b.consumerId WHERE c.name LIKE ? OR c.consumerId LIKE ?";
        try (Connection connection = ConnectionManager.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, "%" + query + "%");
            statement.setString(2, "%" + query + "%");
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Bill bill = new Bill(
                        resultSet.getString("billId"),
                        resultSet.getLong("consumerId"),
                        resultSet.getInt("unit"),
                        resultSet.getString("month"),
                        resultSet.getDouble("amount"),
                        resultSet.getDate("date").toLocalDate(),
                        resultSet.getDate("due_date").toLocalDate(),
                        resultSet.getString("payment_status"),
                        resultSet.getString("transaction_id"),
                        resultSet.getTimestamp("transaction_date_time") != null ? resultSet.getTimestamp("transaction_date_time").toLocalDateTime() : null
                    );
                    bills.add(bill);
                }
            }
        }
        return bills;
    }
}