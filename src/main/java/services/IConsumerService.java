package services;

import models.Consumer;
import java.sql.SQLException;
import java.security.NoSuchAlgorithmException;

public interface IConsumerService {
    void registerConsumer(Consumer consumer, String password) throws SQLException, NoSuchAlgorithmException;
    // Add other methods as needed
}