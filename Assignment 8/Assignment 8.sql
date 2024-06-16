-- Create database lab_8;
create database lab_8;

-- Use database lab_8;
use lab_8;

-- Set delimiter for defining procedure
DELIMITER \\

-- Procedure P1 to calculate area of a circle
create procedure P1 (radius decimal(10,2))
begin
    declare area decimal(10,2);
    declare pi decimal(10,2) default 3.14;
    set area = pi * radius * radius;
    select concat("Area of the circle: ", area) as Area;
end
\\

-- Resetting delimiter to default
DELIMITER ;

-- Calling procedure P1 with radius 20
call P1(20);

-- Use database Lab_8;
use Lab_8;

-- Set delimiter for defining procedure
DELIMITER \\

-- Procedure P2 to calculate square, volume, and double of a number
create procedure P2 (radius decimal(10,2))
begin
    declare square decimal(10,2);
    declare volume decimal(10,2);
    declare twice decimal(10,2);
    set square  = radius * radius;
    set volume = radius * radius * radius;
    set twice = 2 * radius;
    select concat("Square of a number: ", square) as Square;
    select concat("Volume of a number: ", volume) as Volume;
    select concat("Double of a number: ", twice) as Doubles;
end
\\

-- Resetting delimiter to default
DELIMITER ;

-- Calling procedure P2 with radius 3
call P2(3);

-- Use database Lab_8;
use Lab_8;

-- Set delimiter for defining procedure
DELIMITER \\

-- Procedure P3 to swap two variables
create procedure P3 (V1 int, V2 int)
begin
    declare temp int;
    SET V1 := 10;
    SET V2 := 20;
    SELECT CONCAT('Variable 1: ', CAST(V1 AS CHAR));
    SELECT CONCAT('Variable 2: ', CAST(V2 AS CHAR));
    SET temp:= V1;
    SET V1 := V2;
    SET V2 := temp;
    SELECT CONCAT('Variable 1: ', CAST(V1 AS CHAR));
    SELECT CONCAT('Variable 2: ', CAST(V2 AS CHAR));
end;
\\

-- Resetting delimiter to default
DELIMITER ;

-- Calling procedure P3 with values 10 and 20
call P3(10,20);

-- Use database Lab_8;
use Lab_8;

-- Set delimiter for defining procedure
DELIMITER //

-- Procedure P4 to calculate gross pay and net pay after tax
CREATE PROCEDURE P4(
    IN hoursWorked DECIMAL(10, 2),
    IN hourlyRate DECIMAL(10, 2)
)
BEGIN
    DECLARE gP DECIMAL(10, 2);
    DECLARE nP DECIMAL(10, 2);
    SET gP = hoursWorked * hourlyRate;
    SET nP = gP - (gP * 0.28);
    SELECT CONCAT('Hours worked: ', hoursWorked) AS HoursWorked;
    SELECT CONCAT('Hourly rate: ', hourlyRate) AS HourlyRate;
    SELECT CONCAT('Gross pay: ', gP) AS GrossPay;
    SELECT CONCAT('Net pay (after tax): ', nP) AS NetPay;
END 
// 

-- Resetting delimiter to default
DELIMITER ;

-- Calling procedure P4 with hoursWorked 10 and hourlyRate 20
call p4(10,20);

-- Use database Lab_8;
use Lab_8;

-- Set delimiter for defining procedure
DELIMITER //

-- Procedure P5 to concatenate first name and last name
CREATE PROCEDURE P5(
    IN firstName VARCHAR(100),
    IN lastName VARCHAR(100)
)
BEGIN
    DECLARE fullName VARCHAR(200);
    SET fullName = CONCAT(lastName, ', ', firstName);
    SELECT fullName AS Full_Name;
END //

-- Resetting delimiter to default
DELIMITER ;

-- Calling procedure P5 with first name "Atul" and last name "Rajput"
call P5("Atul","Rajput");
