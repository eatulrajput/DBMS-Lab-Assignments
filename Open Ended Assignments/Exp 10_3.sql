CREATE DATABASE Lab10_3;
USE Lab10_3;

CREATE TABLE employees (
 employee_id INT PRIMARY KEY,
 employee_name VARCHAR(100),
 department_id INT,
 salary DECIMAL(10, 2)
);

INSERT INTO employees (employee_id, employee_name, department_id, salary) VALUES
(1, 'John Doe', 10, 90000.00),
(2, 'Jane Smith', 10, 110000.00),
(3, 'Michael Johnson', 20, 95000.00),
(4, 'Emily Brown', 10, 105000.00),
(5, 'Chris Lee', 20, 85000.00);
select * from employees;
DELIMITER //
CREATE PROCEDURE increase_salary_in_department()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE emp_id INT;
    DECLARE emp_name VARCHAR(100);
    DECLARE dept_id INT;
    DECLARE emp_salary DECIMAL(10, 2);
    
    DECLARE cur CURSOR FOR
        SELECT employee_id, employee_name, department_id, salary
        FROM employees
        WHERE department_id = 10;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO emp_id, emp_name, dept_id, emp_salary;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        IF emp_salary < 100000 THEN
            UPDATE employees
            SET salary = salary * 1.15
            WHERE employee_id = emp_id;
        ELSE
            UPDATE employees
            SET salary = salary * 1.10
            WHERE employee_id = emp_id;
        END IF;
    END LOOP;
    
    CLOSE cur;
END//
DELIMITER ;
CALL increase_salary_in_department();
select * from employees;