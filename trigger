CREATE DATABASE bank;
USE bank;

CREATE TABLE Account (
    acc_no INT PRIMARY KEY,
    name VARCHAR(50),
    amount DECIMAL(10,2)
);

INSERT INTO Account VALUES 
(101, 'Rahul', 5000.00),
(102, 'Anita', 7500.00),
(103, 'Suresh', 6200.00),
(104, 'Neha', 8300.00),
(105, 'Amit', 4000.00);

CREATE TABLE Account_log (
    acc_no INT,
    name VARCHAR(50),
    amount DECIMAL(10,2),
    transaction_type VARCHAR(20),
    timestamp DATETIME
);

DELIMITER //

CREATE TRIGGER log_account_update
AFTER UPDATE ON Account
FOR EACH ROW
BEGIN
    DECLARE trans_type VARCHAR(20);
    IF NEW.amount > OLD.amount THEN
        SET trans_type = 'Deposit';
    ELSE
        SET trans_type = 'Withdrawal';
    END IF;

    INSERT INTO Account_log (acc_no, name, amount, transaction_type, timestamp)
    VALUES (NEW.acc_no, NEW.name, ABS(NEW.amount - OLD.amount), trans_type, NOW());
END //

DELIMITER ;
UPDATE Account SET amount = amount + 2000 WHERE acc_no = 101;

SELECT * FROM Account_log;
