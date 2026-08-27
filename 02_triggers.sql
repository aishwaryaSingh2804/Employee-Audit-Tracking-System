-- creating database
CREATE DATABASE employee_audit_system;

USE employee_audit_system;


-- creating employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    age INT,
    country VARCHAR(50),
    department VARCHAR(100),
    position VARCHAR(100),
    salary DECIMAL(12,2),
    joining_date DATE
);


-- inserting data from csv using Table Data Import Wizard


-- checking imported data
SELECT *
FROM employees
LIMIT 10;


-- checking number of employees
SELECT COUNT(*) AS total_employees
FROM employees;


-- creating audit log table
CREATE TABLE audit_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    action_type VARCHAR(20),

    old_salary DECIMAL(12,2),
    new_salary DECIMAL(12,2),

    old_department VARCHAR(100),
    new_department VARCHAR(100),

    old_position VARCHAR(100),
    new_position VARCHAR(100),

    changed_by VARCHAR(100),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- creating insert trigger
DELIMITER //

CREATE TRIGGER employee_after_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN

    INSERT INTO audit_log (
        employee_id,
        action_type,
        new_salary,
        new_department,
        new_position,
        changed_by
    )
    VALUES (
        NEW.employee_id,
        'INSERT',
        NEW.salary,
        NEW.department,
        NEW.position,
        CURRENT_USER()
    );

END //

DELIMITER ;


-- creating update trigger
DELIMITER //

CREATE TRIGGER employee_after_update
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN

    INSERT INTO audit_log (
        employee_id,
        action_type,
        old_salary,
        new_salary,
        old_department,
        new_department,
        old_position,
        new_position,
        changed_by
    )
    VALUES (
        NEW.employee_id,
        'UPDATE',
        OLD.salary,
        NEW.salary,
        OLD.department,
        NEW.department,
        OLD.position,
        NEW.position,
        CURRENT_USER()
    );

END //

DELIMITER ;


-- creating delete trigger
DELIMITER //

CREATE TRIGGER employee_after_delete
AFTER DELETE ON employees
FOR EACH ROW
BEGIN

    INSERT INTO audit_log (
        employee_id,
        action_type,
        old_salary,
        old_department,
        old_position,
        changed_by
    )
    VALUES (
        OLD.employee_id,
        'DELETE',
        OLD.salary,
        OLD.department,
        OLD.position,
        CURRENT_USER()
    );

END //

DELIMITER ;


-- checking triggers
SHOW TRIGGERS;


-- testing update operation
UPDATE employees
SET salary = salary + 5000
WHERE employee_id = 1;


-- checking audit log after update
SELECT *
FROM audit_log
ORDER BY changed_at DESC;


-- testing department update
UPDATE employees
SET department = 'Engineering'
WHERE employee_id = 2;


-- checking audit log
SELECT *
FROM audit_log
ORDER BY changed_at DESC;


-- testing position update
UPDATE employees
SET position = 'Senior Analyst'
WHERE employee_id = 3;


-- checking audit log
SELECT *
FROM audit_log
ORDER BY changed_at DESC;


-- testing delete operation
DELETE FROM employees
WHERE employee_id = 4;


-- checking audit log after delete
SELECT *
FROM audit_log
ORDER BY changed_at DESC;


-- finding all updates
SELECT *
FROM audit_log
WHERE action_type = 'UPDATE'
ORDER BY changed_at DESC;


-- finding all salary changes
SELECT
    employee_id,
    old_salary,
    new_salary,
    new_salary - old_salary AS salary_difference,
    changed_at
FROM audit_log
WHERE action_type = 'UPDATE'
AND old_salary IS NOT NULL
AND new_salary IS NOT NULL;


-- finding employees whose salary increased
SELECT
    employee_id,
    old_salary,
    new_salary,
    new_salary - old_salary AS salary_increase
FROM audit_log
WHERE action_type = 'UPDATE'
AND new_salary > old_salary;


-- finding employees whose salary decreased
SELECT
    employee_id,
    old_salary,
    new_salary,
    old_salary - new_salary AS salary_decrease
FROM audit_log
WHERE action_type = 'UPDATE'
AND new_salary < old_salary;


-- finding department changes
SELECT
    employee_id,
    old_department,
    new_department,
    changed_at
FROM audit_log
WHERE action_type = 'UPDATE'
AND old_department <> new_department;


-- finding position changes
SELECT
    employee_id,
    old_position,
    new_position,
    changed_at
FROM audit_log
WHERE action_type = 'UPDATE'
AND old_position <> new_position;


-- counting operations by type
SELECT
    action_type,
    COUNT(*) AS total_operations
FROM audit_log
GROUP BY action_type;


-- finding most frequently modified employees
SELECT
    employee_id,
    COUNT(*) AS number_of_changes
FROM audit_log
GROUP BY employee_id
ORDER BY number_of_changes DESC;


-- finding changes made by each database user
SELECT
    changed_by,
    COUNT(*) AS total_changes
FROM audit_log
GROUP BY changed_by;


-- finding recent changes
SELECT *
FROM audit_log
ORDER BY changed_at DESC
LIMIT 20;


-- finding changes within a date range
SELECT *
FROM audit_log
WHERE changed_at >= '2026-01-01'
AND changed_at < '2027-01-01'
ORDER BY changed_at DESC;