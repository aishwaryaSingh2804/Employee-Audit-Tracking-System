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