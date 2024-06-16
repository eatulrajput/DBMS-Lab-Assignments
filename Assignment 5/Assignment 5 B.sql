CREATE DATABASE College;
USE College;

CREATE TABLE Major (
    MajorID INT PRIMARY KEY,
    Description VARCHAR(100)
);

CREATE TABLE Faculty (
    FacultyID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    OfficeLocation VARCHAR(100)
);

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    MajorID INT,
    AdvisorID INT,
    FOREIGN KEY (MajorID) REFERENCES Major(MajorID),
    FOREIGN KEY (AdvisorID) REFERENCES Faculty(FacultyID)
);

CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    Title VARCHAR(100),
    PrerequisiteID INT,
    FOREIGN KEY (PrerequisiteID) REFERENCES Course(CourseID)
);

CREATE TABLE CourseSection (
    SectionID INT PRIMARY KEY,
    CourseID INT,
    FacultyID INT,
    Semester VARCHAR(20),
    Year INT,
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
    FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID)
);

INSERT INTO Major (MajorID, Description) VALUES
(1, 'Computer Science'),
(2, 'Electrical Engineering');

INSERT INTO Faculty (FacultyID, FirstName, LastName, OfficeLocation) VALUES
(1, 'John', 'Doe', 'Smith Building, Room 101'),
(2, 'Jane', 'Smith', 'Jones Hall, Room 201');

INSERT INTO Student (StudentID, FirstName, LastName, MajorID, AdvisorID) VALUES
(1, 'Alice', 'Johnson', 1, 1),
(2, 'Bob', 'Smith', 1, 1),
(3, 'Charlie', 'Brown', 2, 2);

INSERT INTO Course (CourseID, Title, PrerequisiteID) VALUES
(1, 'Introduction to Programming', NULL),
(2, 'Data Structures', 1),
(3, 'Computer Networks', 2);

INSERT INTO CourseSection (SectionID, CourseID, FacultyID, Semester, Year) VALUES
(1, 1, 1, 'Spring', 2003),
(2, 2, 2, 'Winter', 2003),
(3, 3, NULL, 'Spring', 2003);

SELECT CONCAT(FirstName, ' ', LastName) AS FullName, Major.Description AS MajorDescription
FROM Student
INNER JOIN Major ON Student.MajorID = Major.MajorID;

SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM Student
INNER JOIN CourseSection ON Student.StudentID = CourseSection.SectionID
WHERE Semester = 'Winter' AND Year = 2003;

SELECT CONCAT(Student.FirstName, ' ', Student.LastName) AS StudentName,
       CONCAT(Faculty.FirstName, ' ', Faculty.LastName) AS AdvisorName,
       Faculty.OfficeLocation
FROM Student
INNER JOIN Faculty ON Student.AdvisorID = Faculty.FacultyID;

SELECT Course.Title, CONCAT(Faculty.FirstName, ' ', Faculty.LastName) AS FacultyName
FROM CourseSection
LEFT JOIN Course ON CourseSection.CourseID = Course.CourseID
LEFT JOIN Faculty ON CourseSection.FacultyID = Faculty.FacultyID
WHERE Semester = 'Spring' AND Year = 2003;

SELECT c.Title AS CourseTitle, p.Title AS PrerequisiteTitle
FROM Course c
LEFT JOIN Course p ON c.PrerequisiteID = p.CourseID;
