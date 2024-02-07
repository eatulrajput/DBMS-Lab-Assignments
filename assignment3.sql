-- Creating Database 
CREATE DATABASE Employee_Database;

-- Using created Database
USE Employee_Database;

-- Create EMPLOYEE table
CREATE TABLE EMPLOYEE (
    EmployeeId INT PRIMARY KEY,
    Lname VARCHAR(50) NOT NULL,
    Fname VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) DEFAULT 0.00,
    Commission DECIMAL(6,2) DEFAULT 0.00
);
SELECT * FROM EMPLOYEE;

-- Create LOCATION table
CREATE TABLE LOCATION (
    RoomId INT PRIMARY KEY,
    Building VARCHAR(50),
    UNIQUE (Building)
);
SELECT * FROM LOCATION;

-- Display all employee names (last name and first name separated by a comma and a space) and salary with appropriate column aliases.
SELECT Lname || ', ' || Fname AS Employee_Name, Salary
FROM EMPLOYEE;

-- Display all employees who do not get any commission.
SELECT * FROM EMPLOYEE
WHERE COMMISSION IS NULL;

-- Display unique building names from LOCATION table.
SELECT DISTINCT BUILDING_NAME
FROM LOCATION;
SELECT * FROM LOCATION;

-- Create Course_Section table
CREATE TABLE Course_Section (
    CsId INT PRIMARY KEY,
    CourseId INT,
    Section INT,
    TermId INT,
    FacultyId INT
);
SELECT * FROM Course_Section;

-- Display all course sections offered in Winter 2003.
-- Assuming there is a 'course_sections' table
SELECT * FROM Course_Section
WHERE TERM = 'Winter 2003';

-- Create TERM table
CREATE TABLE TERM (
    TermId INT PRIMARY KEY,
    TermDesc VARCHAR(50) NOT NULL,
    StartDate DATE,
    EndDate DATE
);
SELECT * FROM TERM;

-- Create FACULTY table
CREATE TABLE FACULTY (
    FacultyId INT PRIMARY KEY,
    Faculty_Name VARCHAR(100) NOT NULL,
    DeptId INT
);
SELECT * FROM FACULTY;


-- Create DEPARTMENT table
CREATE TABLE DEPARTMENT (
    DeptId INT PRIMARY KEY,
    DeptName VARCHAR(100) NOT NULL,
    FacultyId INT,
    UNIQUE (DeptName)
);
SELECT * FROM DEPARTMENT;


-- Display names of faculty members who work in department 1 or 2. Use IN operator in your query.
SELECT Faculty_Name
FROM FACULTY
WHERE DeptId IN (1, 2);

-- Create STUDENT table
CREATE TABLE STUDENT (
    StudentId INT PRIMARY KEY,
    Last VARCHAR(50) NOT NULL,
    First VARCHAR(50) NOT NULL,
    City VARCHAR(50),
    State VARCHAR(50),
    Zip VARCHAR(10),
    StartTerm VARCHAR(20),
    FacultyId INT
);
  SELECT * FROM STUDENT;
 

-- Find all New York and New Jersey students.
SELECT * FROM STUDENT
WHERE State IN ('New York', 'New Jersey');

-- Give a 10% raise to employee number 111.
UPDATE EMPLOYEES
SET salary = salary * 1.1
WHERE EMPLOYEE_ID = 111;

-- Delete department number 30 from the department table. If it is not successful, write down your suggestion to make it work.
-- Assuming there is a 'DEPARTMENTS' table
DELETE FROM DEPARTMENTS
WHERE DEPARTMENT_ID = 30;
-- If not successful, check for foreign key constraints and delete dependent records first

-- For each course ID, display the maximum count in descending order.
-- Assuming there is a 'your_table' table with a 'course_id' and 'count_column'
SELECT course_id, MAX(count_column) AS max_count
FROM your_table
GROUP BY course_id
ORDER BY max_count DESC;

-- Insert a new term in the TERM table.
-- Assuming there is a 'TERM' table
INSERT INTO TERM (term_id, term_name)
VALUES (new_term_id, 'New Term Name');

-- Create a custom prompt for the user to input any value between 50 and 99 into the DeptId column.
-- Assuming there is a 'your_table' table with a 'DeptId' column
ACCEPT dept_id_prompt NUMBER PROMPT 'Enter Department ID (50-99): ';
INSERT INTO your_table (DeptId) VALUES (&dept_id_prompt);

-- Find courses with no required prerequisite.
-- Assuming there is a 'courses' table with a 'prerequisite' column
SELECT *
FROM courses
WHERE prerequisite IS NULL;

-- Display faculty names in descending order by their department, but in alphabetical order by their name within each department.
-- Assuming there is a 'faculty' table with 'faculty_name' and 'department_id' columns
SELECT faculty_name
FROM faculty
ORDER BY department_id DESC, faculty_name;

-- Find faculty members whose name starts with C.
-- Assuming there is a 'faculty' table with 'faculty_name' column
SELECT *
FROM faculty
WHERE faculty_name LIKE 'C%';

-- Find students who started in the year 2003. Use start term column and wildcard.
-- Assuming there is a 'students' table with 'start_term' column
SELECT *
FROM students
WHERE start_term LIKE '2003%';

-- Write SQL*Plus command to display a character column in 30 columns, and a numeric column with 9,999.99 format.
-- Assuming there is a 'your_table' table with 'char_column' and 'num_column' columns
COLUMN char_column FORMAT A30
COLUMN num_column FORMAT 9,999.99
SELECT char_column, num_column
FROM your_table;
