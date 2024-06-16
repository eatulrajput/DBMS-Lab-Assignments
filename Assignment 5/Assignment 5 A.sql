create database Corporation;
use Corporation;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    SupervisorID INT,
    Salary DECIMAL(10, 2),
    PositionID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
    FOREIGN KEY (SupervisorID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Positions (
    PositionID INT PRIMARY KEY,
    PositionDescription VARCHAR(100)
);

CREATE TABLE Qualifications (
    QualificationID INT PRIMARY KEY,
    QualificationDescription VARCHAR(100)
);

CREATE TABLE Dependents (
    DependentID INT PRIMARY KEY,
    EmployeeID INT,
    DependentName VARCHAR(50),
    DependentRelation VARCHAR(50),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'Sales'),
(2, 'Marketing'),
(3, 'Finance');

INSERT INTO Positions (PositionID, PositionDescription) VALUES
(1, 'Manager'),
(2, 'Supervisor'),
(3, 'Executive'),
(4, 'Assistant');

INSERT INTO Qualifications (QualificationID, QualificationDescription) VALUES
(1, 'Bachelor Degree'),
(2, 'Master Degree'),
(3, 'Professional Certification');

INSERT INTO Employees (EmployeeID, FirstName, LastName, 
DepartmentID, SupervisorID, Salary, PositionID) VALUES
(1, 'John', 'Smith', 1, NULL, 60000, 1),
(2, 'Jane', 'Doe', 1, 1, 50000, 2),
(3, 'Michael', 'Johnson', 2, NULL, 55000, 1),
(4, 'Emily', 'Williams', 2, 3, 48000, 4),
(5, 'David', 'Brown', 3, NULL, 70000, 1),
(6, 'Emma', 'Jones', 3, 5, 60000, 3);

INSERT INTO Dependents (DependentID, EmployeeID, DependentName, DependentRelation) VALUES
(1, 1, 'Alice Smith', 'Daughter'),
(2, 2, 'Bob Doe', 'Son'),
(3, 3, 'Charlie Johnson', 'Son'),
(4, 5, 'Olivia Brown', 'Daughter');

SELECT CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

SELECT CONCAT(supervisor.FirstName, ' ', supervisor.LastName) AS SupervisorName
FROM Employees e
LEFT JOIN Employees supervisor ON e.SupervisorID = supervisor.EmployeeID
WHERE e.EmployeeID = 4;

SELECT CONCAT(e.LastName, ', ', e.FirstName) AS EmployeeName, e.Salary,
       CONCAT(supervisor.LastName, ', ', supervisor.FirstName) AS SupervisorName,
       supervisor.Salary AS SupervisorSalary
FROM Employees e
LEFT JOIN Employees supervisor ON e.SupervisorID = supervisor.EmployeeID;
SELECT FirstName, LastName, Salary,
    CASE 
        WHEN Salary >= 70000 THEN 'Senior'
        WHEN Salary >= 60000 THEN 'Mid-level'
        ELSE 'Junior'
    END AS SalaryLevel
FROM Employees;

SELECT e.FirstName, e.LastName, d.DepartmentName, p.PositionDescription
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
INNER JOIN Positions p ON e.PositionID = p.PositionID;

SELECT CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Sales';

SELECT e.FirstName, e.LastName, d.DependentName, d.DependentRelation
FROM Employees e
LEFT JOIN Dependents d ON e.EmployeeID = d.EmployeeID;

SELECT CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName, DATEDIFF(CURDATE(), StartDate) 
AS YearsWorked, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
ORDER BY YearsWorked DESC;

SELECT CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName
FROM Employees e
INNER JOIN Employees john ON john.FirstName = 'John' AND john.LastName = 'Smith'
WHERE e.DepartmentID = john.DepartmentID;





