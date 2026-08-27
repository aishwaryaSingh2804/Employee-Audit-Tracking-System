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