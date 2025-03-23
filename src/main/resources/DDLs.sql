CREATE DATABASE IF NOT EXISTS electricity_billing_system;
use electricity_billing_system;

DROP DATABASE `electricity_billing_system`;

CREATE TABLE consumer (
    consumerId BIGINT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    country_code VARCHAR(10),
    mobile_number VARCHAR(20),
    userId VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE admin (
    id BIGINT PRIMARY KEY,
    hash_token VARCHAR(255) NOT NULL
);

CREATE TABLE logindata (
    userId VARCHAR(255) PRIMARY KEY,
    consumerId BIGINT NOT NULL,
    hash_token VARCHAR(255) NOT NULL,
    FOREIGN KEY (consumerId) REFERENCES consumer(consumerId)
);

CREATE TABLE bill (
    billId VARCHAR(255) PRIMARY KEY,
    consumerId BIGINT NOT NULL,
    unit INT NOT NULL,
    month VARCHAR(20) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    date DATE NOT NULL,
    due_date DATE NOT NULL,
    payment_status VARCHAR(50) NOT NULL,
    transaction_id VARCHAR(255),
    transaction_date_time DATETIME,
    FOREIGN KEY (consumerId) REFERENCES consumer(consumerId)
);

CREATE TABLE complaint (
    complaintId BIGINT PRIMARY KEY,
    complaint_type VARCHAR(255) NOT NULL,
    category VARCHAR(255) NOT NULL,
    contact_person VARCHAR(255),
    consumerId BIGINT NOT NULL,
    mobile_number VARCHAR(20),
    complaint_date DATE NOT NULL,
    problem_description TEXT,
    address TEXT,
    landmark VARCHAR(255),
    FOREIGN KEY (consumerId) REFERENCES consumer(consumerId)
);

select * from complaint;

INSERT INTO bill (billId, unit, month, amount, date, due_date, payment_status, consumerId) VALUES
('BILL001', 100, 'January', 500.00, '2023-01-01', '2023-01-15', 'Unpaid', 8527419632145),
('BILL002', 150, 'February', 750.00, '2023-02-01', '2023-02-15', 'Unpaid', 8527419632145),
('BILL003', 200, 'March', 1000.00, '2023-03-01', '2023-03-15', 'Unpaid', 8527419632145),
('BILL004', 250, 'April', 1250.00, '2023-04-01', '2023-04-15', 'Unpaid', 8527419632145),
('BILL005', 300, 'May', 1500.00, '2023-05-01', '2023-05-15', 'Unpaid', 8527419632145),
('BILL006', 350, 'June', 1750.00, '2023-06-01', '2023-06-15', 'Unpaid', 8527419632145);