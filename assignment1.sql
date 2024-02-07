-- Creating Database 
CREATE DATABASE Student_Database;

-- Using created Database
USE Student_Database;

-- Creating a table to show student records 
CREATE TABLE student (
    RollNo INTEGER,
    Name VARCHAR(50),
    Gender CHAR,
    CGPA FLOAT
);

-- Adding Values in the table Student 
INSERT INTO student VALUES
    (1, 'Arhan', 'M', 5.5),
    (2, 'Anmol', 'F', 8.2),
    (3, 'Atulya', 'F', 5.8),
    (4, 'Raj', 'M', 7.1),
    (5, 'Rohit', 'M', 8.9),
    (6, 'Roshni', 'F', 6.5),
    (7, 'Rohan', 'M', 9.0),
    (8, 'Ujjwala', 'F', 7.3),
    (9, 'Soumit', 'M', 6.0),
    (10, 'Olivia', 'F', 8.5);
    select * from student;
    
-- Using Alter Command to  add column for declaration of Date of birth for every student     
ALTER TABLE student
ADD COLUMN DOB DATE;


-- Using Update command to add Date of Birthday of every student
UPDATE student
SET DOB = '2007-01-01'
WHERE RollNo = 1;

UPDATE student
SET DOB = '2007-08-22'
WHERE RollNo = 2;

UPDATE student
SET DOB = '2007-08-29'
WHERE RollNo = 3;

UPDATE student
SET DOB = '2007-02-10'
WHERE RollNo = 2;

UPDATE student
SET DOB = '2007-08-10'
WHERE RollNo = 4;

UPDATE student
SET DOB = '2007-01-1'
WHERE RollNo = 5;

UPDATE student
SET DOB = '2007-03-21'
WHERE RollNo = 6;

UPDATE student
SET DOB = '2007-02-12'
WHERE RollNo = 7;

UPDATE student
SET DOB = '2007-12-4'
WHERE RollNo = 8;

UPDATE student
SET DOB = '2007-08-11'
WHERE RollNo = 9;

UPDATE student
SET DOB = '2007-08-1'
WHERE RollNo = 10;

-- This is the command for displaying the table visually.
select * from student;

-- This is command for deletion of student record having lowest CGPA.
DELETE FROM student
WHERE CGPA = (SELECT MIN(CGPA) FROM (SELECT CGPA FROM student) AS temp);


-- This is the command for displaying the student record between CGPA 6 to 8
SELECT * FROM student
WHERE CGPA BETWEEN 6 AND 8;

-- This is the command for displaying the recording in ascending order according to CGPA.
SELECT * FROM student
ORDER BY CGPA ASC;

-- This is the command to show the min and max CGPA of the student.
SELECT * FROM student
WHERE CGPA = (SELECT MIN(CGPA) FROM student)
   OR CGPA = (SELECT MAX(CGPA) FROM student);
   
-- This is the command for the student to show records who born after 2006-06-01.   
SELECT * FROM student
WHERE CGPA BETWEEN 6 AND 8
   AND DOB > '2006-06-01';
   
