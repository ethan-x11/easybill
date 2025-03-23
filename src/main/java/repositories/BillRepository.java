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
                    resultSet.getInt("unit"),
                    resultSet.getString("month"),
                    resultSet.getString("date"),
                    resultSet.getString("due_date"),
                    resultSet.getDouble("amount"),
                    resultSet.getString("payment_status"),
                    resultSet.getLong("consumerId"),
                    resultSet.getString("transaction_id"),
                    resultSet.getString("transaction_date_time")
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
                        resultSet.getInt("unit"),
                        resultSet.getString("month"),
                        resultSet.getString("date"),
                        resultSet.getString("due_date"),
                        resultSet.getDouble("amount"),
                        resultSet.getString("payment_status"),
                        resultSet.getLong("consumerId"),
                        resultSet.getString("transaction_id"),
                        resultSet.getString("transaction_date_time")
                    );
                    bills.add(bill);
                }
            }
        }
        return bills;
    }

    public void updateBillPayment(long consumerId, String transactionId, String transactionDateTime, String paymentStatus) throws SQLException {
        String sql = "UPDATE bill SET transaction_id = ?, transaction_date_time = ?, payment_status = ? WHERE consumerId = ? AND payment_status = 'Unpaid'";
        try (Connection connection = ConnectionManager.getConnection();
            PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, transactionId);
            statement.setString(2, transactionDateTime);
            statement.setString(3, paymentStatus);
            statement.setLong(4, consumerId);
            statement.executeUpdate();
        }
    }
}