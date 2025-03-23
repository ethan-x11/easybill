package services;

import models.Bill;
import repositories.BillRepository;
import java.sql.SQLException;
import java.util.List;

public class BillService {
    private final BillRepository billRepository;

    public BillService() {
        this.billRepository = new BillRepository();
    }

    public List<Bill> getAllBills() throws SQLException {
        return billRepository.getAllBills();
    }

    public List<Bill> getBillsByConsumerId(long consumerId) throws SQLException {
        return billRepository.getBillsByConsumerId(consumerId);
    }

    public void updateBillPayment(long consumerId, String transactionId, String transactionDateTime, String paymentStatus) throws SQLException {
        billRepository.updateBillPayment(consumerId, transactionId, transactionDateTime, paymentStatus);
    }
}