CREATE DATABASE Corporation;
USE Corporation;

CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Fname VARCHAR(50),
    Lname VARCHAR(50),
    DepartmentID INT,
    SupervisorID INT,
    Qualification VARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(10, 2),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DeptID),
    FOREIGN KEY (SupervisorID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE Dependent (
    DependentID INT PRIMARY KEY,
    EmployeeID INT,
    DependentName VARCHAR(50),
    Relationship VARCHAR(50),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

INSERT INTO Department (DeptID, DeptName) VALUES
(10, 'HR'),
(20, 'Finance'),
(30, 'Sales'),
(40, 'IT');

INSERT INTO Employee (EmployeeID, Fname, Lname, DepartmentID,
 SupervisorID, Qualification, HireDate, Salary) VALUES
(123, 'Stanley', 'Garner', 20, NULL, 'MBA', '2020-01-01', 50000.00),
(433, 'John', 'Doe', 20, 123, 'BSc', '2018-05-15', 60000.00),
(543, 'Larry', 'Houston', 30, NULL, 'MBA', '2019-03-10', 55000.00),
(654, 'Jinku', 'Shaw', 30, NULL, 'BSc', '2020-06-20', 52000.00);

INSERT INTO Dependent (DependentID, EmployeeID, DependentName, Relationship) VALUES
(1, 123, 'Alice Garner', 'Spouse'),
(2, 123, 'Bob Garner', 'Child'),
(3, 433, 'Jane Doe', 'Child');

SELECT DeptName
FROM Department
WHERE DeptID = (SELECT DepartmentID 
FROM Employee WHERE Lname = 'Shaw' AND Fname = 'Jinku');

SELECT CONCAT(E.Fname, ' ', E.Lname) AS SupervisorName
FROM Employee AS E
WHERE E.EmployeeID = (SELECT SupervisorID FROM Employee WHERE EmployeeID = 433);

SELECT Lname, Fname FROM Employee
WHERE Qualification = (
    SELECT Qualification
    FROM Employee
    WHERE Lname = 'Garner' AND Fname = 'Stanley'
) AND EmployeeID != (
    SELECT EmployeeID  FROM Employee WHERE Lname = 'Garner' AND Fname = 'Stanley'
);

SELECT DeptName
FROM Department
WHERE (SELECT COUNT(*) FROM Employee WHERE DepartmentID = Department.DeptID) >
      (SELECT COUNT(*) FROM Employee WHERE DepartmentID = 20);
      
SELECT CONCAT(E.Fname, ' ', E.Lname) AS EmployeeName
FROM Employee AS E
WHERE E.HireDate < (SELECT HireDate FROM Employee 
WHERE Lname = 'Houston' AND Fname = 'Larry');


SELECT CONCAT(Fname, ' ', Lname) AS EmployeeName
FROM Employee
WHERE DepartmentID = (SELECT DeptID FROM Department WHERE DeptName = 'Sales');

CREATE TABLE EMP30 AS
SELECT EmployeeID, Lname, Fname, HireDate, Salary
FROM Employee
WHERE DepartmentID = (
    SELECT DepartmentID
    FROM Department
    WHERE DeptName = '30'
);


INSERT INTO EMP30 (EmployeeId, Lname, Fname, HireDate)
SELECT EmployeeId, Lname, Fname, HireDate
FROM Employee
WHERE DepartmentId = (
    SELECT DepartmentId
    FROM Department
    WHERE DepartmentName = '40'
);

SELECT Lname, Fname, Salary
FROM Employee e
WHERE Salary = (
    SELECT MIN(Salary)
    FROM Employee
    WHERE DepartmentId = e.DepartmentId
);

SELECT Lname, Fname,
       (SELECT COUNT(*) FROM Dependent WHERE EmployeeId = e.EmployeeId) AS NumDependents
FROM Employee e
WHERE DepartmentId = (
    SELECT DepartmentId
    FROM Department
    WHERE DepartmentName = 'Finance'
);

SELECT Lname, Fname
FROM Employee
WHERE EmployeeId NOT IN (
    SELECT EmployeeId
    FROM Dependent
);

SELECT AVG(Salary) AS AvgSalary
FROM Employee
GROUP BY DepartmentId;

-- Then, you can compare employee 543's salary to these values using a comparison operator.


    


