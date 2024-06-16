CREATE DATABASE IF NOT EXISTS Employee;
USE Employee;
DROP DATABASE IF EXISTS Employee;

CREATE TABLE IF NOT EXISTS Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Employee (
    ID INT PRIMARY KEY,
    Salary DECIMAL(10, 2),
    Name VARCHAR(100),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

INSERT INTO Department (DepartmentID, DepartmentName) VALUES
(1, 'Human Resources'),
(2, 'Marketing'),
(3, 'Finance'),
(4, 'Engineering'),
(5, 'Sales');
SELECT * FROM Department;

INSERT INTO Employee (ID, Salary, Name, DepartmentID) VALUES
(1, 50000.00, 'Arhan Dayal', 1),
(2, 60000.00, 'Arkajyoti Kundu', 2),
(3, 70000.00, 'Arya Vats', 3),
(4, 55000.00, 'Atulya Bihari Singh', 4),
(5, 65000.00, 'Atulya Raj', 5),
(6, 52000.00, 'Ashmit Dutta', 1),
(7, 62000.00, 'Ambrish Kalia', 2),
(8, 72000.00, 'Anmol Shubham', 3),
(9, 58000.00, 'Apurv Krishna Anand', 4),
(10, 68000.00, 'Anurag Kumar', 5);
SELECT * FROM Employee;

SELECT d.DepartmentName
FROM Department d
JOIN Employee e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentID, d.DepartmentName
ORDER BY AVG(e.Salary) DESC
LIMIT 1;

CREATE VIEW MaxSalaryEmployees AS
SELECT e.ID AS EmployeeID, e.Salary, e.Name AS EmployeeName, d.DepartmentName
FROM Employee e
JOIN Department d ON e.DepartmentID = d.DepartmentID
WHERE (e.DepartmentID, e.Salary) IN (
    SELECT DepartmentID, MAX(Salary)
    FROM Employee
    GROUP BY DepartmentID
);
SELECT * FROM MaxSalaryEmployees;

DELIMITER //

CREATE PROCEDURE FindMaxSalaryEmployee (IN department_name VARCHAR(100))
BEGIN
    DECLARE department_id INT;


    SELECT DepartmentID INTO department_id
    FROM Department
    WHERE DepartmentName = department_name;

    SELECT e.ID AS EmployeeID, e.Name, e.Salary
    FROM Employee e
    WHERE e.DepartmentID = department_id
    ORDER BY e.Salary DESC
    LIMIT 1;
END //

DELIMITER ;
CALL FindMaxSalaryEmployee('Human Resources');
CALL FindMaxSalaryEmployee('Marketing');
CALL FindMaxSalaryEmployee('Finance');
CALL FindMaxSalaryEmployee('Engineering');
CALL FindMaxSalaryEmployee('Sales');

