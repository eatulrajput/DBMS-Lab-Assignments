
CREATE DATABASE College;
USE College;

CREATE TABLE Student (
    StudentId INT PRIMARY KEY,
    Fname VARCHAR(50),
    Lname VARCHAR(50),
    AdvisorId INT
);

CREATE TABLE Faculty (
    FacultyId INT PRIMARY KEY,
    Fname VARCHAR(50),
    Lname VARCHAR(50),
    Phone VARCHAR(15)
);

CREATE TABLE Classroom (
    RoomId INT PRIMARY KEY,
    Capacity INT,
    RoomType CHAR(1)
);

CREATE TABLE CourseSection (
    CourseId INT,
    Section VARCHAR(10),
    Semester VARCHAR(20),
    Year INT,
    EnrollmentCount INT,
    FacultyId INT,
    RoomId INT
);

-- Inserting into Student table
INSERT INTO Student (StudentId, Fname, Lname, AdvisorId)
VALUES (1, 'Jose', 'Diaz', 101),
       (2, 'Maria', 'Garcia', 102),
       (3, 'Carlos', 'Martinez', 103);

-- Inserting into Faculty table
INSERT INTO Faculty (FacultyId, Fname, Lname, Phone)
VALUES (101, 'John', 'Smith', '123-456-7890'),
       (102, 'Emily', 'Johnson', '234-567-8901'),
       (103, 'Michael', 'Brown', '345-678-9012');

-- Inserting into Classroom table
INSERT INTO Classroom (RoomId, Capacity, RoomType)
VALUES (1, 30, 'C'),
       (2, 25, 'C'),
       (3, 40, 'L'),
       (4, 20, 'C');

-- Inserting into CourseSection table
INSERT INTO CourseSection (CourseId, Section, Semester, Year, EnrollmentCount, FacultyId, RoomId)
VALUES (101, 'A01', 'Spring', 2003, 25, 101, 1),
       (102, 'B01', 'Spring', 2003, 20, 102, 2),
       (103, 'C01', 'Spring', 2003, 30, 103, 3);
       
       SELECT Faculty.Fname, Faculty.Lname, Faculty.Phone
FROM Student
JOIN Faculty ON Student.AdvisorId = Faculty.FacultyId
WHERE Student.Lname = 'Diaz' AND Student.Fname = 'Jose';

SELECT RoomId, Capacity
FROM Classroom
WHERE RoomType != 'Office'
ORDER BY Capacity
LIMIT 2, 2;

SELECT CourseId, Section
FROM CourseSection
WHERE Semester = 'Spring' AND Year = 2003
ORDER BY EnrollmentCount DESC
LIMIT 3;

SELECT *
FROM Classroom
WHERE RoomType = 'C';

CREATE TABLE SP03SECT AS
SELECT CourseId, Section, FacultyId, RoomId
FROM CourseSection
WHERE Semester = 'Spring' AND Year = 2003;

DELETE FROM SP03SECT
WHERE FacultyId = (
    SELECT FacultyId
    FROM Faculty
    WHERE Lname = 'Mobley'
);

SELECT FacultyId, Fname, Lname
FROM Faculty
WHERE NOT EXISTS (
    SELECT 1
    FROM SP03SECT
    WHERE SP03SECT.FacultyId = Faculty.FacultyId
);


