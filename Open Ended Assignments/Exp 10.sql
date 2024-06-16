CREATE DATABASE lab10;

USE lab10;

CREATE TABLE IF NOT EXISTS EMPLOYEE (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Salary DECIMAL(10, 2),
    HireDate DATE
);

INSERT INTO EMPLOYEE (FirstName, LastName, Salary, HireDate) VALUES 
('John', 'Doe', 50000.00, '1995-05-15'),
('Jane', 'Smith', 60000.00, '1998-03-20'),
('Micky', 'Sen', 55000.00, '1996-10-31'),
('Emily', 'Davis', 48000.00, '1997-11-25');

DELIMITER //

CREATE PROCEDURE PrintEmployeeInfo()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE empFirstName VARCHAR(100);
    DECLARE empLastName VARCHAR(100);
    DECLARE empSalary DECIMAL(10, 2);
    DECLARE empHireDate DATE;
    
    DECLARE employeeCursor CURSOR FOR 
        SELECT LastName, FirstName, Salary, HireDate FROM EMPLOYEE;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN employeeCursor;
    
    read_loop: LOOP
        FETCH employeeCursor INTO empLastName, 
        empFirstName, empSalary, empHireDate;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        IF empSalary > 50000.00 AND empHireDate < '1998-01-01' THEN
            SELECT CONCAT('Employee: ', empFirstName, ' ',
            empLastName, ', Salary: $', empSalary, ', Hire Date: ', empHireDate) 
            AS EmployeeInfo;
        END IF;
    END LOOP;
    
    CLOSE employeeCursor;
END//

DELIMITER ;
CALL PrintEmployeeInfo();