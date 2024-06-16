CREATE DATABASE CompanyDataBase;
USE CompanyDataBase;

CREATE TABLE IF NOT EXISTS EMPLOYEE (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    QualificationID INT,
    Salary DECIMAL(10, 2)
);

INSERT INTO EMPLOYEE (Name, QualificationID, Salary) VALUES 
('John Doe', 1, 50000.00),
('Jane Smith', 2, 60000.00),
('Michael Johnson', 2, 55000.00),
('Emily Davis', 3, 48000.00);

DELIMITER //

CREATE PROCEDURE GetEmployeeByQualification(IN qualID INT)
BEGIN
    DECLARE empCount INT;

    -- Check if qualification exists
    SELECT COUNT(*) INTO empCount FROM EMPLOYEE WHERE QualificationID = qualID;

    IF empCount = 0 THEN
        -- Handle case where no employee with such qualification
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No employees with such qualification';
    ELSEIF empCount > 1 THEN
        -- Handle case where more than one employee with such qualification
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'More than one employee with such qualification';
    ELSE
        -- Retrieve employee details
        SELECT Name, QualificationID, Salary FROM EMPLOYEE WHERE QualificationID = qualID;
    END IF;
END//

DELIMITER ;
CALL GetEmployeeByQualification(1);
CALL GetEmployeeByQualification(2);
CALL GetEmployeeByQualification(6);