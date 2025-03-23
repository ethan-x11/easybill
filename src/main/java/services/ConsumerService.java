package services;

import models.Consumer;
import repositories.ConsumerRepository;
import utils.PasswordEncryption;

import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.List;

public class ConsumerService {
    private ConsumerRepository consumerRepository;

    public ConsumerService() {
        this.consumerRepository = new ConsumerRepository();
    }

    public void registerConsumer(Consumer consumer, String password) throws SQLException, NoSuchAlgorithmException {
        consumerRepository.createConsumer(consumer);
        String hashedPassword = PasswordEncryption.hashPassword(password);
        consumerRepository.createLoginData(consumer.getConsumerId(), consumer.getUserId(), hashedPassword);
    }

    public Consumer validateConsumer(String userId, String password) throws SQLException, NoSuchAlgorithmException {
        String hashedPassword = PasswordEncryption.hashPassword(password);
        return consumerRepository.validateConsumer(userId, hashedPassword);
    }

    public List<Consumer> searchConsumers(String query, String filter) throws SQLException {
        return consumerRepository.searchConsumers(query, filter);
    }
}