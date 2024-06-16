CREATE DATABASE  Lab10_2;
USE Lab10_2;

-- Create employee table
CREATE TABLE IF NOT EXISTS EMPLOYEE (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    LastName VARCHAR(50),
    FirstName VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);

-- Insert sample data
INSERT INTO EMPLOYEE (LastName, FirstName, Salary, HireDate) VALUES 
('Doe', 'John', 80000.00, '1995-05-15'),
('Smith', 'Jane', 75000.00, '1998-03-20'),
('Johnson', 'Michael', 85000.00, '1996-09-10'),
('Dev', 'Emy', 72000.00, '1997-11-25');

-- Create procedure
DELIMITER //

CREATE PROCEDURE PrintEmployeesWithSalaryGreaterThan(
    IN salary_param DECIMAL(10, 2)
)
BEGIN
    DECLARE emp_last_name VARCHAR(50);
    DECLARE emp_first_name VARCHAR(50);
    DECLARE emp_salary DECIMAL(10, 2);
    DECLARE emp_hire_date DATE;
    DECLARE done INT DEFAULT FALSE;
    
    DECLARE emp_cursor CURSOR FOR
        SELECT LastName, FirstName, Salary, HireDate
        FROM EMPLOYEE
        WHERE Salary > salary_param;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN emp_cursor;
    
    emp_loop: LOOP
        FETCH emp_cursor INTO emp_last_name, emp_first_name, emp_salary, emp_hire_date;
        IF done THEN
            LEAVE emp_loop;
        END IF;
        
        -- Print employee information
        SELECT emp_last_name, emp_first_name, emp_salary, emp_hire_date;
    END LOOP;
    
    CLOSE emp_cursor;
END //

DELIMITER ;
CALL PrintEmployeesWithSalaryGreaterThan(70000.00);
