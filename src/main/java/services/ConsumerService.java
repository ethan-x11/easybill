package services;

import models.Consumer;
import repositories.ConsumerRepository;
import utils.PasswordEncryption;

import java.sql.SQLException;
import java.security.NoSuchAlgorithmException;

public class ConsumerService implements IConsumerService {
    private final ConsumerRepository consumerRepository;

    public ConsumerService() {
        this.consumerRepository = new ConsumerRepository();
    }

    @Override
    public void registerConsumer(Consumer consumer, String password) throws SQLException, NoSuchAlgorithmException {
        consumerRepository.createConsumer(consumer);
        String hashedPassword = PasswordEncryption.hashPassword(password);
        consumerRepository.createLoginData(consumer.getConsumerId(), consumer.getUserId(), hashedPassword);
    }

    public Consumer validateConsumer(String userId, String password) throws SQLException, NoSuchAlgorithmException {
        String hashedPassword = PasswordEncryption.hashPassword(password);
        return consumerRepository.validateConsumer(userId, hashedPassword);
    }

    // Implement other methods as needed
}