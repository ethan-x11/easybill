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
    name VARCHAR(100) NOT NULL,
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
    status VARCHAR(50) DEFAULT 'pending' NOT NULL,
    FOREIGN KEY (consumerId) REFERENCES consumer(consumerId)
);

select * from consumer;

INSERT INTO bill (billId, unit, month, amount, date, due_date, payment_status, consumerId) VALUES
('BILL001', 100, 'January', 500.00, '2023-01-01', '2023-01-15', 'Unpaid', 8527419632145),
('BILL002', 150, 'February', 750.00, '2023-02-01', '2023-02-15', 'Unpaid', 8527419632145),
('BILL003', 200, 'March', 1000.00, '2023-03-01', '2023-03-15', 'Unpaid', 8527419632145),
('BILL004', 250, 'April', 1250.00, '2023-04-01', '2023-04-15', 'Unpaid', 8527419632145),
('BILL005', 300, 'May', 1500.00, '2023-05-01', '2023-05-15', 'Unpaid', 8527419632145),
('BILL006', 350, 'June', 1750.00, '2023-06-01', '2023-06-15', 'Unpaid', 8527419632145);

INSERT INTO complaint (complaintId, complaint_type, category, contact_person, consumerId, mobile_number, complaint_date, problem_description, address, landmark) VALUES
(1001, 'billing', 'wrong_charges', 'John Doe', 56165915919, '1234567890', '2023-01-10', 'Incorrect charges on my bill.', '123 Main St', 'Near Park'),
(1002, 'voltage', 'low_voltage', 'Jane Smith', 56165915919, '0987654321', '2023-02-15', 'Experiencing low voltage frequently.', '456 Elm St', 'Opposite Mall'),
(1003, 'disruption', 'power_cut', 'Alice Johnson', 56165915919, '1122334455', '2023-03-20', 'Frequent power cuts in my area.', '789 Oak St', 'Next to School'),
(1004, 'street_light', 'bulb', 'Bob Brown', 56165915919, '2233445566', '2023-04-25', 'Street light bulb is fused.', '321 Pine St', 'Behind Library'),
(1005, 'pole', 'damaged_pole', 'Charlie Davis', 56165915919, '3344556677', '2023-05-30', 'Electric pole is damaged and leaning.', '654 Maple St', 'Near Hospital');

