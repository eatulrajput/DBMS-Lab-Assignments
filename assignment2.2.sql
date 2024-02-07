-- Creating Database 
CREATE DATABASE Corporation_Employee_Database;

-- Using created Database
USE Corporation_Employee_Database;

-- Create EMP_POSITION table
CREATE TABLE EMP_POSITION (
    PositionId INT PRIMARY KEY,
    PosDesc VARCHAR(50) UNIQUE NOT NULL
);

-- Create DEPT table
CREATE TABLE DEPT (
    DeptId INT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL,
    Location VARCHAR(50),
    EmployeeId INT
);

-- Create QUALIFICATION table
CREATE TABLE QUALIFICATION (
    QualId INT PRIMARY KEY,
    QualDesc VARCHAR(50) UNIQUE NOT NULL
);

-- Create EMPLEVEL table
CREATE TABLE EMPLEVEL (
    LevelNo INT PRIMARY KEY,
    LowSalary DECIMAL(10,2) NOT NULL,
    HighSalary DECIMAL(10,2) NOT NULL,
    CHECK (LowSalary < HighSalary)
);

-- Create EMPLOYEE table
CREATE TABLE EMPLOYEE (
    EmployeeId INT PRIMARY KEY,
    Lname VARCHAR(50) NOT NULL,
    Fname VARCHAR(50) NOT NULL,
    PositionId INT,
    Supervisor INT,
    HireDate DATE,
    Salary DECIMAL(10,2) DEFAULT 0.00,
    Commission DECIMAL(6,2) DEFAULT 0.00,
    QualId INT,
    CONSTRAINT fk_position FOREIGN KEY (PositionId) REFERENCES EMP_POSITION(PositionId),
    CONSTRAINT fk_supervisor FOREIGN KEY (Supervisor) REFERENCES EMPLOYEE(EmployeeId),
    CONSTRAINT fk_qual FOREIGN KEY (QualId) REFERENCES QUALIFICATION(QualId)
);

-- Create DEPENDENT table
CREATE TABLE DEPENDENT (
    EmployeeId INT,
    DependentId INT,
    DepDOB DATE,
    Relation VARCHAR(50),
    PRIMARY KEY (EmployeeId, DependentId),
    FOREIGN KEY (EmployeeId) REFERENCES EMPLOYEE(EmployeeId)
);

-- Create EMPLOYEE_DEPT junction table
CREATE TABLE EMPLOYEE_DEPT (
    EmployeeId INT,
    DeptId INT,
    PRIMARY KEY (EmployeeId, DeptId),
    FOREIGN KEY (EmployeeId) REFERENCES EMPLOYEE(EmployeeId),
    FOREIGN KEY (DeptId) REFERENCES DEPT(DeptId)
);

-- Insert records into EMP_POSITION table
INSERT INTO EMP_POSITION VALUES
(1, 'Manager'),
(2, 'Developer'),
(3, 'Analyst'),
(4, 'HR Manager'),
(5, 'Sales Executive');
SELECT * FROM EMP_POSITION;

-- Insert records into QUALIFICATION table
INSERT INTO QUALIFICATION VALUES
(1, 'Bachelor\'s Degree'),
(2, 'Master\'s Degree'),
(3, 'Ph.D.'),
(4, 'Certification'),
(5, 'Diploma');
SELECT * FROM QUALIFICATION;

-- Insert records into EMPLEVEL table
INSERT INTO EMPLEVEL VALUES
(1, 50000.00, 80000.00),
(2, 30000.00, 60000.00),
(3, 25000.00, 50000.00),
(4, 60000.00, 100000.00),
(5, 40000.00, 70000.00);
SELECT * FROM EMPLEVEL;

-- Insert records into DEPT table
INSERT INTO DEPT VALUES
(101, 'IT Department', 'New Delhi', NULL),
(102, 'Finance Department', 'Gurgaon', NULL),
(103, 'HR Department', 'Chennai', NULL),
(104, 'Sales Department', 'Goa', NULL),
(105, 'Marketing Department', 'Kerala', NULL);
SELECT * FROM DEPT;

-- Insert records into EMPLOYEE table
INSERT INTO EMPLOYEE VALUES
(1, 'Arhan', 'Dayal', 1, NULL, '2022-01-15', 75000.00, 1200.00, 1),
(2, 'Arkajyoti', 'Kundu', 2, 1, '2022-02-20', 55000.00, NULL, 2),
(3, 'Ashmit', 'Dutta', 2, 1, '2022-03-10', 60000.00, 10.00, 3),
(4, 'Atulya', 'Raj', 3, 2, '2022-04-05', 45000.00, NULL, 4),
(5, 'Atulya', 'Singh', 2, 1, '2022-05-12', 58000.00, 500.00, 5);
SELECT * FROM EMPLOYEE;

-- Insert records into DEPENDENT table
INSERT INTO DEPENDENT VALUES
(1, 1, '2000-05-05', 'Child'),
(2, 2, '1998-08-15', 'Spouse'),
(3, 3, '2010-02-28', 'Child'),
(4, 4, '2005-10-10', 'Child'),
(5, 5, '1995-03-20', 'Spouse');
SELECT * FROM DEPENDENT;

