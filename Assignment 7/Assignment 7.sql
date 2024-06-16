CREATE DATABASE company;

USE company;
 -- drop database company; 

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10, 2),
    Commission DECIMAL(10, 2)
);

INSERT  INTO Employee(EmployeeID, EmployeeName, DepartmentID, Salary, Commission)
VALUES
(1, 'Arhan Dayal', 101, 50000, 5000),
(2, 'Arkajoyti Kundu', 102, 50400, 5400),
(3, 'Ashmit Dutta', 104, 40000, 4000),
(4, 'Atulya Raj', 104, 20000, 6000),
(5, 'Arya Vats', 105, 55000, 3000);
SELECT  * FROM Employee;

-- Problem 1
CREATE VIEW Employee_Info AS
SELECT EmployeeID, EmployeeName, DepartmentID
FROM Employee;
SELECT  * FROM Employee_Info;

CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

INSERT INTO Department (DepartmentID, DeptName)
 VALUES
(101, 'HR'),
(102, 'IT'),
(103, 'Finance'),
(104, 'Marketing'),
(105, 'Operations');

-- Problem 2
CREATE VIEW Department_AvgSalary AS
SELECT DeptName AS DepartmentName, AVG(Salary) AS AvgSalary
FROM Department
JOIN Employee  ON Department.DepartmentID = Employee.DepartmentID
GROUP BY DeptName;
SELECT * FROM Department_AvgSalary;

-- Problem 3
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50),
    MajorID INT,
    CGPA INT
);

INSERT INTO Student (StudentID, StudentName, MajorID, CGPA)
 VALUES
(1, 'Arhan', 101, 8.5),
(2, 'Arya', 102, 8.8),
(3, 'Arkajyoti', 103, 8.7),
(4, 'Ashmit', 104, 8),
(5, 'Atulya', 105, 7.9);
CREATE INDEX idx_major_id ON Student (MajorID);

-- Problem 4
CREATE TABLE Location (
    RoomID INT PRIMARY KEY,
    LocationName VARCHAR(50)
);

INSERT INTO Location (RoomID, LocationName)
VALUES
(201, 'KP5'),
(202, 'KP5'),
(203,'KP5'),
(204,'KP5'),
(205,'KP5');

INSERT INTO Location (RoomID, LocationName)
 VALUES 
 (206, 'New Room');

SELECT RoomID AS CurrentValue 
FROM Location
ORDER BY RoomID DESC
LIMIT 1;

-- Problem 6
CREATE TABLE Term (
    TermID INT PRIMARY KEY,
    TermName VARCHAR(50) NOT NULL
);

INSERT INTO Term( TermID, TermName)
VALUES
(1, 'Summer 2002'),
(2, 'Winter 2002'),
(3, 'Summer 2003'),
(4, 'Winter 2003'),
(5, 'Summer 2004');

INSERT INTO Term (TermID, TermName)
VALUES (6, 'Winter 2004');
SELECT * FROM Term;

-- Problem 7
START TRANSACTION;

-- Lock the row for update
SELECT * FROM Student WHERE StudentID = '1' FOR UPDATE;

-- Update the major to 600
UPDATE Student SET MajorID = 600 WHERE StudentID = '1';

-- Commit the transaction
COMMIT;
SELECT * FROM Student WHERE StudentID = '1';

-- Problem 8
CREATE VIEW EmployeeData AS
SELECT EmployeeName, Employee.DepartmentID, (Employee.Salary + Employee.Commission)
 AS Total_Income
FROM Employee
JOIN Department ON Employee.DepartmentID = Department.DepartmentID
WHERE Department.DepartmentID = 104;
SELECT * FROM EmployeeData;

-- Problem 9
CREATE VIEW DepartmentIncome AS
SELECT Department.DeptName, SUM(Employee.Salary + Employee.Commission) AS Total_Income
FROM Employee
JOIN Department ON Employee.DepartmentID = Department.DepartmentID
GROUP BY Department.DeptName;

SELECT * FROM DepartmentIncome;

-- Problem 10
INSERT INTO  Department(DepartmentID, DeptName)
 VALUES 
 (106, 'Security');
 
 INSERT  INTO Employee(EmployeeID, EmployeeName, DepartmentID, Salary, Commission)
VALUES
(6, 'Atulya Singh', 103, 50000, 5000);

SELECT Department.DepartmentID, Department.DeptName,
Employee.EmployeeID, Employee.EmployeeName
FROM Department
LEFT JOIN Employee ON Department.DepartmentID = Employee.DepartmentID;


