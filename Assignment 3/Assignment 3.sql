-- Create a new database
CREATE DATABASE IF NOT EXISTS Employee;
USE Employee;

-- Create tables
CREATE TABLE IF NOT EXISTS EMPLOYEE (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary DECIMAL(10, 2),
    commission DECIMAL(5, 2)
);

CREATE TABLE IF NOT EXISTS LOCATION (
    location_id INT PRIMARY KEY,
    building_name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS COURSE_SECTION (
    section_id INT PRIMARY KEY,
    course_id INT,
    term VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS FACULTY (
    faculty_id INT PRIMARY KEY,
    faculty_name VARCHAR(50),
    department_id INT
);

CREATE TABLE IF NOT EXISTS STUDENT (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    state VARCHAR(50),
    start_term VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS DEPARTMENT (
    department_id INT PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS TERM (
    term_id INT PRIMARY KEY,
    term_name VARCHAR(50)
);

-- Insert data
-- (Insert data statements go here)

-- Queries
-- Display all employee names and salary with appropriate column aliases.
SELECT CONCAT(last_name, ', ', first_name) AS employee_name, salary AS employee_salary
FROM EMPLOYEE;

-- Display all employees who do not get any commission.
SELECT *
FROM EMPLOYEE
WHERE commission IS NULL;

-- Display unique building names from LOCATION table.
SELECT DISTINCT building_name
FROM LOCATION;

-- Display all course sections offered in Winter 2003.
SELECT *
FROM COURSE_SECTION
WHERE term = 'Winter 2003';

-- Display names of faculty members who work in department 1 or 2. Use IN operator.
SELECT faculty_name
FROM FACULTY
WHERE department_id IN (1, 2);

-- Find all New York and New Jersey students.
SELECT *
FROM STUDENT
WHERE state IN ('New York', 'New Jersey');

-- Give a 10% raise to employee number 111.
UPDATE EMPLOYEE
SET salary = salary * 1.1
WHERE employee_id = 111;

-- Delete department number 30 from the department table.
DELETE FROM DEPARTMENT
WHERE department_id = 30;
-- If not successful, check for foreign key constraints or dependencies before deletion.

-- For each course ID, display the maximum count in descending order.
SELECT course_id, MAX(count_column) AS max_count
FROM your_table
GROUP BY course_id
ORDER BY max_count DESC;

-- Insert a new term in the TERM table.
INSERT INTO TERM (term_name)
VALUES ('New Term');

-- Create a custom prompt for the user to input any value between 50 and 99 into DeptId column.
SET @dept_id_prompt := 0; -- Initialize a variable
SET @dept_id_prompt := (SELECT IF(@dept_id_prompt BETWEEN 50 AND 99, @dept_id_prompt, NULL)); -- Validate input
INSERT INTO your_table (DeptId) VALUES (@dept_id_prompt);

-- Find courses with no required prerequisite.
SELECT *
FROM COURSE
WHERE prerequisite IS NULL;

-- Display faculty names in descending order by their department, but in alphabetical order by their name within each department.
SELECT faculty_name
FROM FACULTY
ORDER BY department_id DESC, faculty_name;

-- Find faculty members whose name starts with C.
SELECT *
FROM FACULTY
WHERE faculty_name LIKE 'C%';

-- Find students who started in the year 2003. Use start term column and wild card.
SELECT *
FROM STUDENT
WHERE start_term LIKE '2003%';

-- Write SQL*Plus command to display a character column in 30 columns, and a numeric column with 9,999.99 format.
-- MySQL does not have a direct equivalent to SQL*Plus commands. Display settings are usually managed by the client interface.
-- However, you can format results in the SELECT query itself.
SELECT LPAD(char_column, 30, ' ') AS char_column, FORMAT(numeric_column, 2) AS numeric_column
FROM your_table;
