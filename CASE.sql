
-- CASE in SELECT
SELECT 
    column_name,
    CASE expression
        WHEN value1 THEN result1
        WHEN value2 THEN result2
        ELSE default_result
    END AS alias_name
FROM
    table_name;



-- example_1: CASE in SELECT : HR
SELECT 
    first_name,
    last_name,
    hire_date,
    department_name,
    job_title,
    CASE
        WHEN (YEAR(CURDATE()) - YEAR(hire_date)) = 1 THEN '1 year'
        WHEN (YEAR(CURDATE()) - YEAR(hire_date)) = 2 THEN '2 years'
        WHEN (YEAR(CURDATE()) - YEAR(hire_date)) = 3 THEN '3 years'
        WHEN (YEAR(CURDATE()) - YEAR(hire_date)) = 4 THEN '4 years'
        WHEN (YEAR(CURDATE()) - YEAR(hire_date)) = 5 THEN '5 years'
        WHEN (YEAR(CURDATE()) - YEAR(hire_date)) = 6 THEN '6 years'
        WHEN (YEAR(CURDATE()) - YEAR(hire_date)) = 7 THEN '7 years'
        WHEN (YEAR(CURDATE()) - YEAR(hire_date)) = 8 THEN '8 years'
        WHEN (YEAR(CURDATE()) - YEAR(hire_date)) = 9 THEN '9 years'
        WHEN (YEAR(CURDATE()) - YEAR(hire_date)) = 10 THEN '10 years'
        ELSE CONCAT(YEAR(CURDATE()) - YEAR(hire_date),
                ' years')
    END AS anniversary
FROM
    employees e
        JOIN
    departments d USING (department_id)
        JOIN
    jobs j USING (job_id)
ORDER BY hire_date ASC;

-- example_2
SELECT 
    employee_id,
    last_name,
    CASE department_id
        WHEN 9 THEN 'Executive'
    END AS department_name
FROM
    employees;

-- example_3
SELECT 
    first_name,
    last_name,
    YEAR(hire_date) AS hire_year,
    CASE
        WHEN hire_date < '1990-01-01' THEN 'Executive'
        ELSE 'Other'
    END AS department_name
FROM
    employees
LIMIT 5;

-- example_4
SELECT 
    first_name,
    last_name,
    salary,
    CASE
        WHEN salary < 3000 THEN 'Low'
        WHEN salary >= 3000 AND salary <= 5000 THEN 'Average'
        WHEN salary > 5000 THEN 'High'
    END evaluation
FROM
    employees;

-- CASE in UPDATE 
UPDATE table_name 
SET 
    column_name = CASE
        WHEN condition1 THEN result1
        WHEN condition2 THEN result2
        ELSE default_result
    END
WHERE
    some_condition
;

-- example_
USE HUMANRESOURCE;
SELECT 
    employee_id,
    department_id,
    first_name,
    last_name,
    salary,
    CASE
        WHEN department_id = 3 THEN salary * (1 + 20 / 100)
        WHEN department_id = 5 THEN salary * 1.2
        WHEN department_id = 1 THEN salary * 1.2
        ELSE salary
    END AS new_salary
FROM
    employees
;

-- Multiple column UPDATE 
UPDATE table_name 
SET 
    column1 = CASE
        WHEN condition1 THEN value1
        WHEN condition2 THEN value2
        ELSE default_value1
    END,
    column2 = CASE
        WHEN condition1 THEN value3
        WHEN condition2 THEN value4
        ELSE default_value2
    END
WHERE
    some_condition;

