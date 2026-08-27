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

-- checking imported data
SELECT *
FROM employees
LIMIT 10;

-- checking number of employees
SELECT COUNT(*) AS total_employees
FROM employees;