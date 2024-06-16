-- Create the database
CREATE DATABASE company_database;

-- Use the database
USE company_database;

-- Create the department table
CREATE TABLE employee_department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(55)
);

-- Insert some sample data into the department table
INSERT INTO employee_department (department_id, department_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Marketing'),
(5, 'Operations');

-- Display the contents of the department table
SELECT * FROM employee_department;

-- Create the employee table
CREATE TABLE employee (
    employee_id INT PRIMARY KEY,
    last_name VARCHAR(55),
    first_name VARCHAR(55),
    salary DECIMAL(10, 2),
    commission DECIMAL(10, 2),
    hire_date DATE,
    department VARCHAR(55),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES employee_department(department_id)
);


-- Create the location table
CREATE TABLE location (
    location_id INT PRIMARY KEY,
    room_number INT,
    building_name VARCHAR(55)
);

-- Create the student table
CREATE TABLE student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(55),
    birth_date DATE
);

-- Create the dependents table
CREATE TABLE dependents (
    dependent_id INT PRIMARY KEY,
    employee_id INT,
    dependent_name VARCHAR(50),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(55),
    prerequisite VARCHAR(55)
);

CREATE TABLE faculty (
    faculty_id INT PRIMARY KEY,
    faculty_name VARCHAR(55),
    department VARCHAR(55)
);

-- Insert data into the employee table
INSERT INTO employee (employee_id, last_name, first_name, salary, commission, hire_date, department, department_id)
VALUES
(1, 'Kundu', 'Arkajyoti', 60000, 5000, '2020-01-15', 'HR', 1),
(2, 'Dayal', 'Arhan', 75000, NULL, '2019-05-20', 'IT', 2),
(3, 'Vats', 'Arya', 66000, 5000, '2020-01-15', 'Finance', 3),
(4, 'Raj', 'Atulya', 65000, NULL, '2020-01-15', 'Marketing', 4),
(5, 'Singh', 'Atulya', 67000, 5000, '2020-01-15', 'Operations', 5);

-- Insert data into the location table
INSERT INTO location (location_id, room_number, building_name)
VALUES
(1, 101, 'Buildin A'),
(2, 201, 'Building B'),
(3, 301, 'Building C'),
(4, 401, 'Building D'),
(5, 501, 'Building E');

-- Insert data into the student table
INSERT INTO student (student_id, student_name, birth_date)
VALUES
(1, 'Akriti Sharma', '2004-11-24'),
(2, 'Shreya Gupta', '2002-12-26'),
(3, 'Himanshi Singh', '2002-05-04'),
(4, 'Divya Singh', '2000-05-12'),
(5, 'Ashmita Dutta ', '2002-03-25');

-- Insert data into the dependents table
INSERT INTO dependents (employee_id, dependent_id, dependent_name)
VALUES
(1, 1, 'Dependent1'),
(1, 2, 'Dependent2'),
(2, 3, 'Dependent3'),
(2, 4, 'Dependent4'),
(3, 5, 'Dependent5');


-- Insert data into the courses table
INSERT INTO courses (course_id, course_name, prerequisite)
VALUES
(1, 'Computer Science', NULL),
(2, 'Database Management', 'Computer Science'),
(3, 'Operating System', 'COA'),
(4, 'English', NULL),
(5, 'Cyber Security', NULL);

-- Insert data into the faculty table
INSERT INTO faculty (faculty_id, faculty_name, department)
VALUES
(1, 'Dr. Sharma', 'Computer Science'),
(2, 'Prof. Dev', 'Database Management'),
(3, 'Dr. Sweta', 'Operating System'),
(4, 'Dr. Arun', 'English'),
(5, 'Prof Taruna', 'Cyber Security');

-- Display all employee names with proper case and salary with currency format
SELECT CONCAT(UPPER(SUBSTRING(first_name,1,1)), SUBSTRING(first_name,2) , ", ", last_name) AS employee_name,
CONCAT("$ ", FORMAT(salary, 'C'))as formatted_salary FROM employee;

-- Display all employees with their commission value or 0 if no commission
SELECT last_name, first_name, COALESCE(commission, 0) as commission
FROM employee;

-- Count the total number of rooms in LOCATION
SELECT COUNT(room_number) as total_rooms
FROM location;

-- Count the distinct building names in LOCATION
SELECT COUNT(DISTINCT building_name) as distinct_buildings
FROM location;

-- Display all student names and birth dates with a specific format
SELECT student_name, DATE_FORMAT(birth_date, '%d %M, %Y') as formatted_birth_date
FROM student;

-- Find the average, highest, and lowest age for students
SELECT AVG(YEAR(NOW()) - YEAR(birth_date)) as average_age,
       MAX(YEAR(NOW()) - YEAR(birth_date)) as highest_age,
       MIN(YEAR(NOW()) - YEAR(birth_date)) as lowest_age
FROM student;

-- Display the total number of dependents for each employee with at least two dependents
SELECT employee_id, COUNT(dependent_id) as total_dependents
FROM dependents
GROUP BY employee_id
HAVING COUNT(dependent_id) >= 2;


-- Display only the year value from each employee’s hire date
SELECT employee_id, YEAR(hire_date) as hire_year
FROM employee;

-- Find average employee commission ignoring nulls
SELECT AVG(commission) as average_commission
FROM employee
WHERE commission IS NOT NULL;

-- Create the course_counts table
CREATE TABLE course_counts (
    term VARCHAR(55),
    course VARCHAR(55),
    count INT,
    PRIMARY KEY (term, course)
);

-- Insert some sample data into the course_counts table
INSERT INTO course_counts (term, course, count) VALUES
('Spring', 'Math101', 20),
('Spring', 'Physics101', 15),
('Spring', 'Chemistry101', 25),
('Fall', 'Math101', 18),
('Fall', 'Physics101', 20),
('Fall', 'Chemistry101', 22);

-- Find sum of Maximum count by term by course (GROUP BY two columns)
SELECT term, course, SUM(max_count) AS sum_of_max_count
FROM (
    SELECT term, course, MAX(count) AS max_count
    FROM course_counts
    GROUP BY term, course
) AS subquery
GROUP BY term, course;


-- Find 2 to the power 10
SELECT POWER(2, 10) as power_result;

-- Display courses and prerequisites as 'one' or 'none'
SELECT course_name, CASE WHEN prerequisite IS NULL THEN 'none' ELSE 'one' END as prerequisite_status
FROM courses;

-- Count number of faculty members by each department
SELECT department, COUNT(faculty_id) as faculty_count
FROM faculty
GROUP BY department;



-- Display average employee salary by department, excluding departments with average salary less than $75,000
SELECT ed.department_name, AVG(e.salary) AS avg_salary
FROM employee e
JOIN employee_department ed ON e.department_id = ed.department_id
GROUP BY ed.department_name;

SELECT ed.department_name, AVG(e.salary) AS avg_salary
FROM employee e
JOIN employee_department ed ON e.department_id = ed.department_id
GROUP BY ed.department_name
HAVING AVG(e.salary) >= 75000;


-- Find number of years employees have been working for (display integer part only)
SELECT employee_id, FLOOR(DATEDIFF(NOW(), hire_date) / 365) as years_worked
FROM employee;

-- Find students who are born in the month of May
SELECT student_name
FROM student
WHERE MONTH(birth_date) = 5;

-- Display employee’s last name, first name, followed by salary+commission or salary only if commission is not null
SELECT last_name, first_name, CONCAT(salary, IFNULL('+' || commission, '')) as salary_info
FROM employee;

-- Display employee’s full name followed by a message based on salary
SELECT CONCAT(last_name, ', ', first_name) as full_name,
       CASE 
           WHEN salary > 100000 THEN 'HIGH'
           WHEN salary BETWEEN 50000 AND 100000 THEN 'MEDIUM'
           ELSE 'LOW'
       END as salary_message
FROM employee;

