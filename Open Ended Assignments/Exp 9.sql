CREATE DATABASE lab9;

USE lab9;

DELIMITER //

CREATE PROCEDURE IsLeapYear(IN year_val INT, OUT is_leap_year BOOLEAN)
BEGIN
    IF ((year_val % 4 = 0) AND (year_val % 100 != 0)) OR (year_val % 400 = 0) THEN
        SET is_leap_year = TRUE;
    ELSE
        SET is_leap_year = FALSE;
    END IF;
END//

DELIMITER ;

CALL IsLeapYear(2000, @is_leap_year);
SELECT @is_leap_year;


DELIMITER //

CREATE PROCEDURE PrintOddNumbers()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 10 DO
        IF i % 2 != 0 THEN
            SELECT i;
        END IF;
        SET i = i + 1;
    END WHILE;
END//

DELIMITER ;
CALL PrintOddNumbers();

DELIMITER //

CREATE PROCEDURE PrintReverseOrder()
BEGIN
    DECLARE i INT DEFAULT 10;
    WHILE i >= 1 DO
        SELECT i;
        SET i = i - 1;
    END WHILE;
END//

DELIMITER ;
CALL PrintReverseOrder();

CREATE TABLE ITEM (
    ItemNum INT
);

DELIMITER //

CREATE PROCEDURE InsertItemNumbers()
BEGIN
    DECLARE num INT DEFAULT 1;
    WHILE num <= 5 DO
        INSERT INTO ITEM (ItemNum) VALUES (num);
        SET num = num + 1;
    END WHILE;
END//

DELIMITER ;
CALL InsertItemNumbers();
SELECT * FROM ITEM;

DELIMITER //

CREATE PROCEDURE MultiplicationTable(IN num INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 10 DO
        SELECT CONCAT(num, ' x ', i, ' = ', num * i) AS Result;
        SET i = i + 1;
    END WHILE;
END//

DELIMITER ;
CALL MultiplicationTable(5);

