USE humanresource;

SELECT 
    CONCAT(UPPER(e.last_name),
            ', ',
            SUBSTRING(e.first_name, 1, 1),
            '.') AS employee_name,
    d.department_id,
    d.department_name,
    e.salary
FROM
    employees e
        JOIN
    departments d USING (department_id)
WHERE
    e.salary = (SELECT 
            MAX(em.salary)
        FROM
            employees em
        WHERE
            em.department_id = e.department_id)
ORDER BY e.salary DESC;



SELECT 
    e.last_name,
    e.first_name,
    e.salary 'highest_per_department',
    d.department_id,
    d.department_name
FROM
    employees e
        JOIN
    departments d USING (department_id)
WHERE
    e.salary = (SELECT 
            MAX(salary)
        FROM
            employees em
        WHERE
            em.department_id = e.department_id)
ORDER BY department_id ASC;

SELECT 
    e.last_name,
    e.first_name,
    e.salary 'lowest_per_department',
    d.department_id,
    d.department_name
FROM
    employees e
        JOIN
    departments d USING (department_id)
WHERE
    e.salary = (SELECT 
            MIN(salary)
        FROM
            employees em
        WHERE
            em.department_id = e.department_id)
ORDER BY department_id ASC;


SELECT 
    CONCAT(UPPER(e.last_name),
            ', ',
            SUBSTRING(e.first_name, 1, 1),
            '.') AS employee_name,
    d.department_id,
    d.department_name,
    e.salary AS salary,
    'Highest' AS salary_type
FROM
    employees e
        JOIN
    departments d USING (department_id)
        JOIN
    (SELECT 
        department_id, MAX(salary) AS max_salary
    FROM
        employees
    GROUP BY department_id) stats ON e.department_id = stats.department_id
WHERE
    e.salary = stats.max_salary 
UNION ALL SELECT 
    CONCAT(UPPER(e.last_name),
            ', ',
            SUBSTRING(e.first_name, 1, 1),
            '.') AS employee_name,
    d.department_id,
    d.department_name,
    e.salary AS salary,
    'Lowest' AS salary_type
FROM
    employees e
        JOIN
    departments d USING (department_id)
        JOIN
    (SELECT 
        department_id, MIN(salary) AS min_salary
    FROM
        employees
    GROUP BY department_id) stats ON e.department_id = stats.department_id
WHERE
    e.salary = stats.min_salary
ORDER BY department_id , salary_type DESC;