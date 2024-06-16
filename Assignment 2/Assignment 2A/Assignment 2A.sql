-- Creating Database 
CREATE DATABASE College_Student_Database;

-- Using created Database
USE College_Student_Database;

-- Create STUDENT table
CREATE TABLE STUDENT (
    StudentId INT PRIMARY KEY,
    Last VARCHAR(50) NOT NULL,
    First VARCHAR(50) NOT NULL,
    Street VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    Zip VARCHAR(10),
    StartTerm VARCHAR(20),
    BirthDate DATE,
    FacultyId INT,
    MajorId INT,
    Phone VARCHAR(20) UNIQUE
);
  SELECT * FROM STUDENT;
 
-- Create FACULTY table
CREATE TABLE FACULTY (
    FacultyId INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    RoomId INT,
    Phone VARCHAR(20) UNIQUE,
    DeptId INT
);
SELECT * FROM FACULTY;

-- Create COURSE table
CREATE TABLE COURSE (
    CourseId INT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Credits INT,
    PreReq INT
);

-- Create TERM table
CREATE TABLE TERM (
    TermId INT PRIMARY KEY,
    TermDesc VARCHAR(50) NOT NULL,
    StartDate DATE,
    EndDate DATE
);

-- Create LOCATION table
CREATE TABLE LOCATION (
    RoomId INT PRIMARY KEY,
    Building VARCHAR(50),
    RoomNo VARCHAR(20),
    Capacity INT,
    RoomType VARCHAR(50),
    UNIQUE (Building, RoomNo)
);

-- Create CRSSECTION table
CREATE TABLE CRSSECTION (
    CsId INT PRIMARY KEY,
    CourseId INT,
    Section INT,
    TermId INT,
    FacultyId INT,
    Day VARCHAR(10),
    StartTime TIME,
    EndTime TIME,
    RoomId INT,
    MaxCount INT,
    FOREIGN KEY (CourseId) REFERENCES COURSE(CourseId),
    FOREIGN KEY (TermId) REFERENCES TERM(TermId),
    FOREIGN KEY (FacultyId) REFERENCES FACULTY(FacultyId),
    FOREIGN KEY (RoomId) REFERENCES LOCATION(RoomId)
);



-- Create ROOM table
CREATE TABLE ROOM (
    RoomId INT PRIMARY KEY,
    RoomType VARCHAR(50),
    RoomDesc VARCHAR(100),
    UNIQUE (RoomId, RoomType)
);

-- Create REGISTRATION table
CREATE TABLE REGISTRATION (
    StudentId INT,
    CsId INT,
    Midterm INT,
    Final INT,
    RegStatus VARCHAR(20),
    PRIMARY KEY (StudentId, CsId),
    FOREIGN KEY (StudentId) REFERENCES STUDENT(StudentId),
    FOREIGN KEY (CsId) REFERENCES CRSSECTION(CsId)
);

-- Create DEPARTMENT table
CREATE TABLE DEPARTMENT (
    DeptId INT PRIMARY KEY,
    DeptName VARCHAR(100) NOT NULL,
    FacultyId INT,
    UNIQUE (DeptName),
    FOREIGN KEY (FacultyId) REFERENCES FACULTY(FacultyId)
);

-- Create MAJOR table
CREATE TABLE MAJOR (
    MajorId INT PRIMARY KEY,
    MajorDesc VARCHAR(100) NOT NULL,
    UNIQUE (MajorDesc)
);


-- Insert records into STUDENT table
INSERT INTO STUDENT VALUES
(1, 'Arhan', 'Dayal', 'Campus 12', 'Bhubaneshwar', 'Odisha', '72120', 'Autumn2022', '2004-10-20', 101, 201, '123-456-7890'),
(2, 'Arya', 'Vats', 'Campus 12', 'Bhubaneshwar', 'Odisha', '54321', 'Autumn2022', '2004-12-26', 102, 202, '987-654-3210'),
(3, 'Arkajyoti', 'Kundu', 'Campus 12', 'Bhubaneshwar', 'Odisha', '67890', 'Autumn2022', '2004-03-08', 103, 203, '555-555-5555'),
(4, 'Atulya', 'Singh', 'Campus 13', 'Bhubaneshwar', 'Odisha', '11111', 'Autumn2022', '2004-02-04', 104, 204, '111-222-3333'),
(5, 'Ashmit', 'Dutta', 'Campus 12', 'Bhubaneshwar', 'Odisha', '22222', 'Autumn2022', '1994-03-10', 105, 205, '999-888-7777');
SELECT * FROM STUDENT;

-- Insert records into FACULTY table
INSERT INTO FACULTY VALUES
(101, 'Dr. Bhargav', 501, '111-111-1111', 301),
(102, 'Prof. Mishra', 502, '222-222-2222', 302),
(103, 'Dr. Krishna', 503, '333-333-3333', 303),
(104, 'Prof. Arya', 504, '444-444-4444', 304),
(105, 'Dr. Vats', 505, '555-555-5555', 305);
SELECT * FROM FACULTY;

-- Insert records into COURSE table
INSERT INTO COURSE VALUES
(201, 'Introduction to Programming', 3, NULL),
(202, 'Database Management', 4, 201),
(203, 'Data Structures', 3, 201),
(204, 'Software Engineering', 4, 202),
(205, 'Computer Networks', 3, NULL);
SELECT * FROM COURSE;

-- Insert records into TERM table
INSERT INTO TERM VALUES
(1, 'Autumn 2022', '2022-09-01', '2022-12-15'),
(2, 'Autumn 2023', '2023-01-10', '2023-04-30'),
(3, 'Autumn 2023', '2023-09-05', '2023-12-20'),
(4, 'Autumn 2024', '2024-01-15', '2024-05-05'),
(5, 'Autumn 2024', '2024-06-01', '2024-08-15');
SELECT * FROM TERM;

-- Insert records into LOCATION table
INSERT INTO LOCATION VALUES
(601, 'Building A', '101', 50, 'Classroom'),
(602, 'Building B', '201', 30, 'Lab'),
(603, 'Building C', '202', 40, 'Classroom'),
(604, 'Building D', '301', 25, 'Lab'),
(605, 'Building E', '302', 60, 'Classroom');
SELECT * FROM LOCATION;

-- Insert records into CRSSECTION table
INSERT INTO CRSSECTION VALUES
(301, 201, 1, 1, 101, 'Mon', '08:00:00', '10:00:00', 601, 30),
(302, 202, 1, 1, 102, 'Tue', '10:30:00', '12:30:00', 602, 25),
(303, 203, 1, 1, 103, 'Wed', '14:00:00', '16:00:00', 603, 35),
(304, 204, 1, 1, 104, 'Thu', '16:30:00', '18:30:00', 604, 20),
(305, 205, 1, 1, 105, 'Fri', '13:00:00', '15:00:00', 605, 40);
SELECT * FROM CRSSECTION;

-- Insert records into ROOM table
INSERT INTO ROOM VALUES
(601, 'Classroom', 'Room 101'),
(602, 'Lab', 'Lab 201'),
(603, 'Classroom', 'Room 202'),
(604, 'Lab', 'Lab 301'),
(605, 'Classroom', 'Room 302');
SELECT * FROM ROOM;

-- Insert records into REGISTRATION table
INSERT INTO REGISTRATION VALUES
(1, 301, 85, 90, 'Registered'),
(2, 302, 78, 85, 'Registered'),
(3, 303, 92, 88, 'Registered'),
(4, 304, 80, 95, 'Registered'),
(5, 305, 88, 86, 'Registered');
SELECT * FROM REGISTRATION;

-- Insert records into DEPARTMENT table
INSERT INTO DEPARTMENT VALUES
(301, 'Computer Science', 101),
(302, 'Electrical Engineering', 102),
(303, 'Mechanical Engineering', 103),
(304, 'Civil Engineering', 104),
(305, 'Mathematics', 105);
SELECT * FROM DEPARTMENT;

-- Insert records into MAJOR table
INSERT INTO MAJOR VALUES
(201, 'Computer Science'),
(202, 'Electrical Engineering'),
(203, 'Mechanical Engineering'),
(204, 'Civil Engineering'),
(205, 'Mathematics');
SELECT * FROM MAJOR;

