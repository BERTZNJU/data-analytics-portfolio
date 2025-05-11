/*

WITH cte_name AS (
    SELECT column1, column2, ...
    FROM some_table
    WHERE condition
)
SELECT *
FROM cte_name;

*/


WITH ranked_employees AS (
    SELECT 
        e.last_name,
        e.salary,
        d.department_id,
        d.department_name,
        RANK() OVER (PARTITION BY d.department_id ORDER BY e.salary DESC) AS salary_ranking
    FROM employees e
    JOIN departments d USING (department_id)
)
SELECT last_name, salary, department_id, department_name
FROM ranked_employees
WHERE salary_ranking = 1;


WITH department_rankings AS (
    SELECT 
        d.department_id, 
        d.department_name, 
        COUNT(e.employee_id) AS employee_count
        
    FROM employees e 
    JOIN departments d USING (department_id)
    GROUP BY d.department_id, d.department_name
)
SELECT department_name 
FROM department_rankings 
WHERE employee_count > 5;


WITH department_rankings AS (
    SELECT 
        d.department_id, 
        d.department_name, 
        COUNT(e.employee_id) AS employee_count
    FROM employees e 
    JOIN departments d USING (department_id)
    GROUP BY d.department_id, d.department_name
),
assessment AS (
    SELECT 
        department_id,
        department_name,
        employee_count,
        CASE 
            WHEN employee_count > 6 THEN 'high'
            WHEN employee_count = 5 THEN 'normal'
            ELSE 'low'
        END AS employee_assessment
    FROM department_rankings
)
SELECT department_name, employee_count, employee_assessment
FROM assessment;





WITH RECURSIVE employee_hierarchy AS (
    SELECT 
        employee_id,
        last_name,
        first_name,
        department_name,
        manager_id,
        1 AS LEVEL
    FROM employees e 
    JOIN departments d USING (department_id)  
    WHERE manager_id IS NULL

    UNION ALL

    SELECT 
        em.employee_id,
        em.last_name,
        em.first_name,
        d.department_name,
        em.manager_id,
        r.LEVEL + 1
    FROM employees em 
    JOIN departments d USING (department_id) 
    JOIN employee_hierarchy r ON em.manager_id = r.employee_id
)
SELECT * 
FROM employee_hierarchy
ORDER BY LEVEL, last_name, first_name;

WITH dept_salaries AS (
    SELECT
        department_id,
        department_name,
        MAX(salary) AS maximum_salary,
        MIN(salary) AS minimum_salary,
        ROUND(AVG(salary), 2) AS average_salary
    FROM employees e
    JOIN departments d USING (department_id)
    GROUP BY department_id, department_name
)
SELECT *,
       RANK() OVER (ORDER BY maximum_salary DESC) AS ranking
FROM dept_salaries
ORDER BY ranking;

WITH dept_salaries AS (
    SELECT
        department_id,
        department_name,
        MAX(salary) AS maximum_salary,
        MIN(salary) AS minimum_salary,
        ROUND(AVG(salary), 2) AS average_salary
    FROM employees e
    JOIN departments d USING (department_id)
    GROUP BY department_id, department_name
)SELECT 
	*,
    DENSE_RANK () OVER (ORDER BY maximum_salary DESC)
FROM dept_salaries WHERE maximum_salary BETWEEN 10000 AND 15000
AND department_id IN (7, 10);




