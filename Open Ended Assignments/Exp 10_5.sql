-- Create database
CREATE DATABASE IF NOT EXISTS UniversityDB;
USE UniversityDB;

-- Create COURSE table
CREATE TABLE IF NOT EXISTS COURSE (
    CourseID VARCHAR(10) PRIMARY KEY,
    CourseName VARCHAR(100),
    Instructor VARCHAR(100),
    CreditHours INT
);

-- Insert sample data
INSERT INTO COURSE (CourseID, CourseName, Instructor, CreditHours) VALUES 
('CIS101', 'Introduction to Computer Science', 'Dr. Smith', 3),
('MAT202', 'Advanced Mathematics', 'Dr. Johnson', 4),
('ENG301', 'English Literature', 'Prof. Adams', 3);

-- Create procedure
DELIMITER //

CREATE PROCEDURE RetrieveCourseInfo(
    IN courseID_param VARCHAR(10)
)
BEGIN
    DECLARE courseFound INT DEFAULT 0;
    
    -- Check if course exists
    SELECT COUNT(*) INTO courseFound FROM COURSE WHERE CourseID = courseID_param;
    
    IF courseFound = 0 THEN
        -- Course does not exist, throw user-defined exception
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Course does not exist';
    ELSE
        -- Course exists, print its information
        SELECT * FROM COURSE WHERE CourseID = courseID_param;
    END IF;
    
END//

DELIMITER ;

CALL RetrieveCourseInfo('CIS102');